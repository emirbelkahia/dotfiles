# Changelog

All notable changes to this repository are documented in this file.

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
