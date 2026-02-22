# dotfiles

Config files for my terminal setup.

## What's in here

| File | Description |
|------|-------------|
| `.zshrc` | Shell config — aliases, PATH, tools init |
| `.tmux.conf` | tmux — pink status bar, solid pane borders |

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
