# Changelog

All notable changes to this repository are documented in this file.

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
