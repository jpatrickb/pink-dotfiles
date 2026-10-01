#!/bin/bash
# Mac bootstrap: Xcode CLT -> Homebrew -> chezmoi -> apply these dotfiles.
# Usage:  ./bootstrap.sh <github-user>/<repo>
#   or:   bash -c "$(curl -fsSL https://raw.githubusercontent.com/<user>/<repo>/main/bootstrap.sh)" -- <user>/<repo>
# (Cluster: skip this -- see README.md.)
set -euo pipefail
REPO="${1:?usage: bootstrap.sh <github-user>/<repo>}"

xcode-select -p >/dev/null 2>&1 || { echo "Installing Xcode command line tools (a dialog will appear)..."; xcode-select --install; echo "Re-run this script when that finishes."; exit 0; }

if ! command -v brew >/dev/null 2>&1 && [ ! -x /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

command -v chezmoi >/dev/null 2>&1 || brew install chezmoi
chezmoi init --apply "$REPO"     # asks for name + email, then installs tools and writes configs

cat <<'MSG'

Done. Last steps:
  1. VS Code: install the "Pink" theme by Lucy, then paste the keys from
     ~/.config/pink-theme/vscode-settings.jsonc into your User Settings (JSON).
  2. Open a NEW terminal in VS Code.
MSG
