"""Local dictation worker. JSON-lines stdin/stdout; audio never leaves this process.

Model acquisition is an explicit setup operation; normal operation is offline.
"""
import argparse
import json
import os
from pathlib import Path
import queue
import signal
import sys
import tempfile
import threading
import time

STATE = Path.home() / '.local/share/hammerspoon-dictation'
MODEL = 'mlx-community/parakeet-tdt-0.6b-v3'
REVISION = 'ed2b7e8c15f9aaa0b5772e2efb986255eaef7e15'
RATE = 16000
MAX_SECONDS = 180


def emit(kind, session=None, **values):
    print(json.dumps(dict(type=kind, id=session, **values), ensure_ascii=False), flush=True)


def setup_model():
    from huggingface_hub import snapshot_download
    path = snapshot_download(MODEL, revision=REVISION,
                             allow_patterns=['config.json', 'model.safetensors'])
    STATE.mkdir(parents=True, exist_ok=True)
    (STATE / 'model-path').write_text(path)
    print('Model downloaded. Normal dictation runs offline.')


class Control:
    """Stop capture immediately, even while the main thread is doing inference."""
    def __init__(self):
        self.commands = queue.Queue()
        self.stop = threading.Event()
        self.cancel = threading.Event()
        self.quit = threading.Event()
        self.session = None

    def read(self):
        try:
            for line in sys.stdin:
                try:
                    command = json.loads(line)
                except (ValueError, TypeError):
                    continue
                if command.get('op') == 'quit':
                    break
                if command.get('id') == self.session:
                    if command.get('op') in ('stop', 'cancel'):
                        self.stop.set()
                    if command.get('op') == 'cancel':
                        self.cancel.set()
                if command.get('op') == 'start' and self.session is None:
                    self.stop.clear()
                    self.cancel.clear()
                    self.session = command.get('id')
                    self.commands.put(command)
        finally:
            self.shutdown()

    def shutdown(self, *_):
        self.quit.set()
        self.cancel.set()
        self.stop.set()


def load_model():
    os.environ['HF_HUB_OFFLINE'] = '1'
    os.environ['HF_HUB_DISABLE_TELEMETRY'] = '1'
    os.environ.setdefault('NUMBA_CACHE_DIR', str(STATE / 'numba-cache'))
    import mlx.core as mx
    from parakeet_mlx import from_pretrained
    from parakeet_mlx.audio import get_logmel
    path = (STATE / 'model-path').read_text().strip()
    model = from_pretrained(path)
    # Materialize weights and compile inference kernels before opening the mic.
    model.generate(get_logmel(mx.zeros(RATE), model.preprocessor_config))
    mx.eval(model.parameters())
    return model


def final_transcript(model, audio, cancelled=lambda: False):
    """Re-decode with full attention in overlapping 30s windows."""
    import mlx.core as mx
    import numpy as np
    from parakeet_mlx.audio import get_logmel
    from parakeet_mlx.alignment import (
        merge_longest_contiguous, merge_longest_common_subsequence,
        sentences_to_result, tokens_to_sentences,
    )
    if len(audio) < RATE // 5 or np.max(np.abs(audio)) < 0.001:
        return ''
    tokens = []
    for offset in range(0, len(audio), 27 * RATE):
        if cancelled():
            return ''
        part = audio[offset:offset + 30 * RATE]
        if len(part) < RATE // 5:
            break
        result = model.generate(get_logmel(mx.array(part), model.preprocessor_config))[0]
        for token in result.tokens:
            token.start += offset / RATE
            token.end = token.start + token.duration
        if tokens and result.tokens:
            try:
                tokens = merge_longest_contiguous(tokens, result.tokens, overlap_duration=3)
            except RuntimeError:
                tokens = merge_longest_common_subsequence(tokens, result.tokens, overlap_duration=3)
        elif result.tokens:
            tokens = result.tokens
        if offset + 30 * RATE >= len(audio):
            break
    return sentences_to_result(tokens_to_sentences(tokens)).text.strip()


def record(model, control):
    import numpy as np
    import sounddevice as sd
    import soundfile as sf
    session = control.session
    audio_queue = queue.Queue(maxsize=600)  # Up to 60 seconds of backlog.
    overflow = threading.Event()

    def callback(data, frames, timing, status):
        if control.stop.is_set():
            raise sd.CallbackStop
        if status.input_overflow:
            overflow.set()
        try:
            audio_queue.put_nowait(data[:, 0].copy())
        except queue.Full:
            overflow.set()
            raise sd.CallbackAbort

    with tempfile.TemporaryDirectory(prefix='hammerspoon-dictation-') as folder:
        wav = Path(folder) / 'recording.wav'
        blocks = []
        deadline = time.monotonic() + MAX_SECONDS
        with sf.SoundFile(wav, mode='w', samplerate=RATE, channels=1, subtype='PCM_16') as output:
            with sd.InputStream(samplerate=RATE, channels=1, dtype='float32',
                                blocksize=1600, callback=callback):
                emit('recording', session)
                while not control.stop.is_set():
                    if overflow.is_set():
                        raise RuntimeError('Audio input overflow. Please try a shorter dictation.')
                    if time.monotonic() >= deadline:
                        control.stop.set()
                        emit('limit', session)
                        break
                    try:
                        block = audio_queue.get(timeout=0.1)
                    except queue.Empty:
                        continue
                    blocks.append(block)
                    output.write(block)
            # Capture is closed before inference; drain samples already accepted.
            while not audio_queue.empty():
                block = audio_queue.get_nowait()
                blocks.append(block)
                output.write(block)
        if control.cancel.is_set():
            emit('cancelled', session)
            return
        if overflow.is_set():
            raise RuntimeError('Audio input overflow. No incomplete transcript was pasted.')
        emit('finalizing', session)
        audio = np.concatenate(blocks) if blocks else np.array([], dtype=np.float32)
        text = final_transcript(model, audio, control.cancel.is_set)
        if control.cancel.is_set():
            emit('cancelled', session)
        else:
            emit('final', session, text=text)
        # TemporaryDirectory removes WAV on completion, cancellation, and exceptions.


def serve():
    control = Control()
    signal.signal(signal.SIGTERM, control.shutdown)
    signal.signal(signal.SIGINT, control.shutdown)
    threading.Thread(target=control.read, daemon=True).start()
    emit('loading')
    model = load_model()
    emit('ready')
    while not control.quit.is_set():
        try:
            command = control.commands.get(timeout=0.2)
        except queue.Empty:
            continue
        control.session = command.get('id')
        try:
            if control.cancel.is_set():
                emit('cancelled', control.session)
            elif not control.quit.is_set():
                record(model, control)
        except Exception as error:
            emit('error', control.session, message=str(error))
        finally:
            control.session = None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--setup', action='store_true')
    parser.add_argument('--file', help='Test decoding of a WAV without opening the mic')
    args = parser.parse_args()
    if args.setup:
        setup_model()
    elif args.file:
        import soundfile as sf
        model = load_model()
        audio, rate = sf.read(args.file, dtype='float32')
        if rate != RATE or audio.ndim != 1:
            raise ValueError('Test WAV must be mono 16 kHz')
        start = time.monotonic()
        emit('final', text=final_transcript(model, audio), seconds=round(time.monotonic() - start, 2))
    else:
        serve()


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        emit('fatal', message=str(error))
        sys.exit(1)
