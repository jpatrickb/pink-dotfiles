#!/bin/bash
# Usage: thea-test/run.sh [shell]   -- builds the image, applies the dotfiles as
# an unprivileged user, then runs checks (or drops you into bash with "shell").
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
PLATFORM="${PLATFORM:-linux/amd64}"
docker build -q --platform "$PLATFORM" -t thea-cluster-test "$HERE" >/dev/null
INNER='
set -e
mkdir -p ~/.config/chezmoi
printf "[data]\n  name = \"Thea Test\"\n  email = \"thea@example.com\"\n  isHPC = true\n" > ~/.config/chezmoi/chezmoi.toml
curl -fsSL get.chezmoi.io | sh -s -- -b ~/.local/bin >/dev/null
export PATH=$HOME/.local/bin:$PATH
chezmoi init --apply --source /repo
echo; echo "=== apply done ==="
'
if [ "${1:-}" = shell ]; then
  docker run --rm -it --platform "$PLATFORM" -v "$HERE/..:/repo:ro" thea-cluster-test bash -c "$INNER"'; exec bash -l'
else
  docker run --rm -t --platform "$PLATFORM" -v "$HERE/..:/repo:ro" thea-cluster-test bash -c "$INNER"'
bash -lic "echo SHELL_OK; for c in starship atuin eza bat delta fzf zoxide; do printf \"%s: \" \$c; command -v \$c || echo MISSING; done; echo BLE=\${BLE_VERSION:-none}; echo PS1_set=\${PS1:+yes}; git config --get delta.syntax-theme; echo --; ls -A ~; echo -- zshrc:; head -3 ~/.zshrc 2>&1; grep -n pink ~/.bashrc" 2>&1 | tail -40'
fi
