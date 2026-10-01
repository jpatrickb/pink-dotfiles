#!/bin/bash
# bat only discovers themes in ~/.config/bat/themes after an explicit cache
# build. Fast, so it runs on every apply and also picks up future changes.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
command -v bat >/dev/null 2>&1 && bat cache --build >/dev/null 2>&1
exit 0
