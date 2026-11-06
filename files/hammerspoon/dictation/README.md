# Local dictation

- **Cmd+.**: record; press again to finalize and paste.
- **Cmd+Shift+.**: paste the last completed, nonempty transcription again.
  It stays in memory until Hammerspoon reloads or quits. Cancelled recordings
  and silence do not replace it. Finish or cancel an active recording first.
- **Escape**: cancel without pasting.
- A compact bottom-of-screen badge shows recording, loading, or transcription
  status. It disappears when done. There is no live preview or partial insertion.
- If focus changes during finalization, the result stays in memory, with a small “Ready” badge. Focus
  the desired text field and press Cmd+. to paste it.
- Recording stops after three minutes. The first use loads the model; subsequent
  recordings reuse it until Hammerspoon exits or reloads.

## Setup

On gp-mac, Nix provides `hammerspoon-dictation-setup`. Run it once after activating
that configuration. Alternatively, with Python 3.13 available:

```sh
sh ~/.hammerspoon/dictation/setup.sh
```

The setup installs pinned Python dependencies into
`~/.local/share/hammerspoon-dictation/venv` and downloads a pinned Parakeet V3 MLX
model revision into the Hugging Face cache. The Nix setup command pins the Python
interpreter; Python wheels/model weights are bootstrapped separately and are not
Nix derivations. No root privileges are needed for this setup.

Allow Hammerspoon microphone access if macOS prompts. Accessibility access is
needed for the shortcut and paste. The default macOS input device is used.

## Privacy and limitations

Normal inference uses offline mode. There are no cloud calls or AI rewriting.
Audio is held in memory and a private temporary WAV; normal completion,
cancellation, and handled errors remove the WAV. Forced process termination or a
system crash can leave a temporary folder in the macOS temporary directory.
The latest completed transcript is retained in memory for Cmd+Shift+.; no
transcript history is saved to disk. Model weights and the Python environment remain.

Parakeet V3 supports English and Portuguese without a language lock. Mixed
language accuracy is not guaranteed; test with your own speech. A synthetic
bilingual sample preserved both languages but confused one Portuguese word.

The clipboard is restored after a one-second paste interval, unless another app
or the user changes it. Hammerspoon's readAllData/writeAllData preserves the
first clipboard item's formats; multi-item Finder clipboards are not guaranteed.
The final paste goes to the focused app and does not send Return. Secure input
blocks insertion. Apps that do not support ordinary Cmd+V may need manual paste.

## Development checks

The helper's `--file path.wav` mode tests decoding without opening
the microphone. Input must be mono 16 kHz WAV. Run `test_helper.py` with the same
venv interpreter for lifecycle and cancellation tests (requires local Metal).
Python is launched with `-B` so bytecode files do not trigger Hammerspoon's config
reload watcher. Keep generated files outside this directory.
