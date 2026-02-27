#!/bin/bash
set -e

OS="$(uname)"

echo "🔧 Installing tools..."

if [ "$OS" = "Darwin" ]; then
  # macOS
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install bat eza fd zoxide ripgrep btop
  brew install --cask font-jetbrains-mono-nerd-font

elif [ "$OS" = "Linux" ]; then
  # Linux (Ubuntu/Debian)
  sudo apt update
  sudo apt install -y bat fd-find ripgrep btop
  # eza and zoxide via cargo (not in apt)
  if ! command -v cargo &>/dev/null; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
  cargo install eza zoxide
  # fd is installed as fdfind on Debian/Ubuntu
  [ ! -f ~/.local/bin/fd ] && mkdir -p ~/.local/bin && ln -s $(which fdfind) ~/.local/bin/fd
fi

echo "🔗 Creating symlinks..."
ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

echo "✅ Done. Run 'source ~/.zshrc' to apply."
