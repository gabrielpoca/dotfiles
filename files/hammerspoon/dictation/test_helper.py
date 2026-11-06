"""Lifecycle regression tests using a fake input stream, never the microphone."""
import io
from pathlib import Path
import tempfile
import threading
import unittest
from unittest.mock import patch

import numpy as np
import helper


class FakeModel:
    def transcribe_stream(self, **kwargs):
        return self

    def __enter__(self):
        return self

    def __exit__(self, *args):
        pass


class LifecycleTests(unittest.TestCase):
    def control(self):
        control = helper.Control()
        control.session = 42
        return control

    def run_record(self, cancel=False, failure=False):
        control = self.control()
        events, folders = [], []
        real_tempdir = tempfile.TemporaryDirectory

        def tempdir(**kwargs):
            folder = real_tempdir(**kwargs)
            folders.append(Path(folder.name))
            return folder

        class Input:
            def __init__(self, callback, **kwargs):
                self.callback = callback

            def __enter__(self):
                if failure:
                    raise RuntimeError('Microphone unavailable')
                class Status:
                    input_overflow = False
                self.callback(np.ones((1600, 1), dtype=np.float32) * .1, 1600, None, Status())
                if cancel:
                    control.cancel.set()
                control.stop.set()
                return self

            def __exit__(self, *args):
                pass

        with patch('sounddevice.InputStream', Input), \
             patch.object(helper.tempfile, 'TemporaryDirectory', tempdir), \
             patch.object(helper, 'emit', lambda kind, *args, **kw: events.append((kind, kw))), \
             patch.object(helper, 'final_transcript', return_value='Olá, deployment ready.') as final:
            if failure:
                with self.assertRaisesRegex(RuntimeError, 'Microphone unavailable'):
                    helper.record(FakeModel(), control)
            else:
                helper.record(FakeModel(), control)
            if cancel or failure:
                final.assert_not_called()
            else:
                self.assertEqual(final.call_args.args[1].shape, (1600,))
        self.assertTrue(folders)
        self.assertTrue(all(not path.exists() for path in folders))
        return events

    def test_stop_drains_audio_finalizes_and_removes_wav(self):
        events = self.run_record()
        self.assertEqual([kind for kind, _ in events], ['recording', 'finalizing', 'final'])
        self.assertEqual(events[-1][1]['text'], 'Olá, deployment ready.')

    def test_cancel_removes_wav_without_final(self):
        self.assertEqual([kind for kind, _ in self.run_record(cancel=True)], ['recording', 'cancelled'])

    def test_microphone_failure_removes_tempdir(self):
        self.run_record(failure=True)

    def test_cancel_before_main_thread_picks_up_start_is_preserved(self):
        control = helper.Control()
        data = '{"op":"start","id":7}\n{"op":"cancel","id":7}\n'
        with patch('sys.stdin', io.StringIO(data)):
            control.read()
        self.assertEqual(control.commands.get_nowait()['id'], 7)
        self.assertTrue(control.cancel.is_set())
        self.assertTrue(control.stop.is_set())

    def test_stale_stop_does_not_cancel_new_session(self):
        control = self.control()
        # Keep stdin open long enough to inspect flags before the EOF shutdown.
        def lines():
            yield '{"op":"cancel","id":41}\n'
            self.assertFalse(control.cancel.is_set())
            self.assertFalse(control.stop.is_set())
        with patch('sys.stdin', lines()):
            control.read()
        self.assertTrue(control.quit.is_set())

    def test_silence_does_not_hallucinate(self):
        self.assertEqual(helper.final_transcript(None, np.zeros(16000)), '')


if __name__ == '__main__':
    unittest.main()
