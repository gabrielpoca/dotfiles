#!/bin/sh
set -eu
source_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
state="$HOME/.local/share/hammerspoon-dictation"
python="${DICTATION_PYTHON:-python3}"
mkdir -p "$state"
"$python" -m venv "$state/venv"
"$state/venv/bin/python" -m pip install --disable-pip-version-check -r "$source_dir/requirements.lock"
"$state/venv/bin/python" "$source_dir/helper.py" --setup
