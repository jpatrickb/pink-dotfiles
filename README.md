# Pink dotfiles

Shell setup managed with [chezmoi](https://chezmoi.io): a light pink / fuchsia / purple theme
matching the VS Code "Pink" theme, a pill-style prompt (starship), pretty git diffs (delta),
searchable history (atuin), and suggestions as you type.

All colours live in **one file**: `.chezmoidata/theme.toml`. Change a value there, run
`chezmoi apply`, and every tool updates.

## Mac (zsh)
```sh
./bootstrap.sh <github-user>/<repo>
```
Installs Homebrew packages (see `Brewfile`), then writes the configs. Then paste
`~/.config/pink-theme/vscode-settings.jsonc` into VS Code's user settings.

## Cluster (bash, no sudo)
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply <github-user>/<repo>
```
Answer **yes** to "Is this a shared cluster". Everything installs under your home directory,
and one line is added to `~/.bashrc` (your existing contents are untouched).
Log out and back in. If a tool fails to download, the shell still works; re-run
`chezmoi state delete-bucket --bucket=scriptState && chezmoi apply` to retry.

## Day to day
- `chezmoi update` pulls changes; `chezmoi edit ~/.config/starship.toml` edits a config.
- Ctrl-R: search history. Right-arrow: accept the grey suggestion.
- If the prompt shows boxes instead of icons, set the terminal font to **JetBrainsMono Nerd Font**.

## Testing (for the person maintaining this)
- `test/run.sh` builds a Rocky 9 container (no sudo, bash) and applies the cluster profile.
- Mac: `chezmoi apply --source . --destination ~/pink-test --config ~/pink-test/.chezmoi.toml --exclude scripts`
