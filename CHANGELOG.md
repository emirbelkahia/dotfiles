# Changelog

All notable changes to this repository are documented in this file.

## 2026-03-03 (3)

### Added

- `bin/tc` — call transcription tool migrated from Desktop `transcribe_callv3.command`. Pure bash, unchanged logic. Hardcoded paths replaced with `$HOME`. Colored `--help` added (usage, what it does, output paths, full new-machine setup instructions for whisper.cpp). `ffmpeg` added to Homebrew install in `install.sh`.

## 2026-03-03 (2)

### Changed

- `bin/ooo --help` — replaced plain text extraction with a dedicated `show_help()` function using ANSI colors. Section headers in bold yellow, commands and paths in cyan, hints in gray.

## 2026-03-03

### Added

- `bin/ooo` — Gmail out-of-office setter in pure bash (curl + jq + nc). No Python, no venv. Supports interactive mode, direct args (`ooo 2026-03-10 2026-03-17`), `--setup` for first-time OAuth via localhost callback, and `--help`. Config lives in `~/.config/ooo/` (never committed — `credentials.json` in 1Password).
- `bin/` convention — personal CLI scripts versioned in `dotfiles/bin/`, symlinked to `~/bin` on PATH. Add scripts here to make them available on any machine after `./install.sh`.
- `jq` added to Homebrew install in `install.sh`.
- `$HOME/bin` added to PATH in `.zshrc`.
- `ln -sf "$HOME/dotfiles/bin" "$HOME/bin"` added to `install.sh` symlink section.

## 2026-03-02

### Added

- `zsh-autosuggestions` — fish-like command suggestions based on history. Installed via Homebrew, sourced in `.zshrc`.
- Finder path bar (`ShowPathbar`) — shows the full file path at the bottom of every Finder window permanently, without holding Option.
- `hammerspoon/init.lua` — time overlay triggered by `Cmd+Alt+T`. Displays current time in large pink text on a dark semi-transparent background for 2 seconds. Installed via `brew install --cask hammerspoon`, symlinked by `install.sh`.

## 2026-03-01

### Added

- `macos.sh` — macOS `defaults write` speed optimizations script with full revert support. Disables animations (window open/close, Dock launch bounce, Mission Control, Quick Look, Finder), sets keyboard repeat to max speed, configures Finder (search current folder, full path in title, no .DS_Store on network/USB), screenshots to ~/Downloads without shadow/thumbnail, save/print dialogs expanded by default. Run `./macos.sh revert` to undo everything.

## 2026-02-28

### Added

- `set -g mouse on` in `.tmux.conf` — enables mouse scroll in tmux panes. Use scroll wheel to navigate history, `q` or `Escape` to exit scroll mode.

## 2026-02-27

### Added

- `VIRTUAL_ENV_DISABLE_PROMPT=1` — prevents venv's `activate` script from modifying the prompt, which was causing a duplicate `(venv)` to appear on its own line before the custom prompt.
- JetBrains Mono Nerd Font added to `install.sh` — auto-installs on macOS for icon support in `eza`, tmux, etc.

### Fixed

- Venv prompt duplication: venv name was showing twice (once from `activate`, once from `_prompt_env_segment`).

## 2026-02-26

### Added

- `claude-sonnet`, `claude-haiku`, `claude-opus` aliases — launch Claude CLI with the corresponding model and `--dangerously-skip-permissions` in one command. Use generic model aliases (e.g. `sonnet`) so they auto-point to the latest version without needing dotfiles updates.

## 2026-02-25

### Added

- Minimal two-line zsh prompt.
- Blank separator line before each prompt render.
- First line shows current working directory.
- Optional Python/Conda environment segment when active.

### Changed

- `ls`/`ll` now use `eza` with `--icons=auto` when available.
- Added fallback to native `ls -F` / `ls -laF` when `eza` is missing (useful on SSH hosts).
- README now documents prompt behavior and icon-based listing.
