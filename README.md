# dotfiles

Config files for my terminal setup.

## What's in here

| File | Description |
|------|-------------|
| `.zshrc` | Shell config — aliases, PATH, tools init |
| `.tmux.conf` | tmux — pink status bar, solid pane borders, mouse scroll |
| `macos.sh` | macOS `defaults write` optimizations (animations, keyboard, Finder, screenshots) |
| `CHANGELOG.md` | Changes history |

## Tools used

| Tool | Replaces | Install |
|------|----------|---------|
| [bat](https://github.com/sharkdp/bat) | `cat` | `brew install bat` |
| [eza](https://github.com/eza-community/eza) | `ls` | `brew install eza` |
| [fd](https://github.com/sharkdp/fd) | `find` | `brew install fd` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | `brew install ripgrep` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | `brew install zoxide` |
| [btop](https://github.com/aristocratos/btop) | `top` | `brew install btop` |

## Install on a new machine

```bash
git clone git@github.com:emirbelkahia/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
source ~/.zshrc
```

Works on macOS and Linux (Ubuntu/Debian).

> Secrets (API keys, tokens) go in `~/.zshrc.local` — never committed.

## Claude aliases

Three aliases to launch Claude CLI directly with a specific model and `--dangerously-skip-permissions`:

| Alias | Command |
|-------|---------|
| `claude-sonnet` | `claude --model sonnet --dangerously-skip-permissions` |
| `claude-haiku` | `claude --model haiku --dangerously-skip-permissions` |
| `claude-opus` | `claude --model opus --dangerously-skip-permissions` |

Model aliases are generic (e.g. `sonnet` not `claude-sonnet-4-6`) so they always point to the latest version.

## Prompt and `ls` behavior

### `ls` with icons

`ls` and `ll` use `eza` when available, with an SSH-friendly fallback:

```zsh
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto --group-directories-first"
  alias ll="eza -la --icons=auto --group-directories-first --git"
else
  alias ls="ls -F"
  alias ll="ls -laF"
fi
```

This keeps icons locally when your terminal/font supports them, and avoids broken output on remote hosts without `eza`.

### Minimal prompt (more scannable)

The prompt is intentionally 2 lines:

1. Working directory + active environment (venv/conda if any)
2. A simple `>` prompt marker

A blank line is added before each prompt by starting `PROMPT` with a leading newline:

```zsh
PROMPT=$'\n%F{45}%~%f$(_prompt_env_segment)\n%F{244}>%f '
```

`_prompt_env_segment` prints `VIRTUAL_ENV` or `CONDA_DEFAULT_ENV` only when present.

`VIRTUAL_ENV_DISABLE_PROMPT=1` is set to prevent the venv `activate` script from also modifying the prompt — without this, the env name would appear twice.

## macOS optimizations

`macos.sh` applies speed-focused `defaults write` settings. Run once after a fresh install:

```bash
./macos.sh          # apply all optimizations
./macos.sh revert   # undo everything back to macOS defaults
```

What it does:
- Disables window/Dock/Finder/Mission Control animations
- Sets keyboard repeat to max speed
- Finder: search current folder by default, show full path, no .DS_Store on network/USB
- Screenshots: saved to ~/Downloads, no shadow, no thumbnail
- Save/Print dialogs: expanded by default

All changes persist across reboots. Restart recommended after apply/revert.

Inspired by [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) — specifically the [`.macos`](https://github.com/mathiasbynens/dotfiles/blob/main/.macos) script by [Mathias Bynens](https://mathiasbynens.be/), the most widely used macOS `defaults write` reference (31k+ stars).

## Fonts

`install.sh` installs **JetBrains Mono Nerd Font** on macOS for icon support in `eza` and tmux.

Make sure your terminal emulator is configured to use it.
