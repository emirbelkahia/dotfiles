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
  brew install bat eza fd zoxide ripgrep btop zsh-autosuggestions jq ffmpeg
  brew install --cask font-jetbrains-mono-nerd-font hammerspoon

  # ---------------------------------------------------------------------------
  # whisper.cpp — local speech-to-text engine used by tc
  # ---------------------------------------------------------------------------
  # This is NOT installed automatically (requires cmake build).
  # On a new machine, run the following manually:
  #
  #   git clone https://github.com/ggml-org/whisper.cpp.git ~/whisper.cpp
  #   cmake -B ~/whisper.cpp/build ~/whisper.cpp
  #   cmake --build ~/whisper.cpp/build --config Release
  #
  # Then download the models into ~/whisper.cpp/models/:
  #   cd ~/whisper.cpp
  #   bash models/download-ggml-model.sh large-v3-turbo   # transcription model
  #
  # For the VAD model (filters silence to avoid hallucinations):
  #   Download "for-tests-silero-v5.1.2-ggml.bin" from:
  #   https://github.com/ggml-org/whisper.cpp/releases
  #   and place it in ~/whisper.cpp/models/
  #
  # See also: tc --help
  # ---------------------------------------------------------------------------

  echo "🐍 Setting up sms-export venv..."
  python3 -m venv "$HOME/.venv/sms-export"
  "$HOME/.venv/sms-export/bin/pip" install --quiet iphone-backup-decrypt

  # ---------------------------------------------------------------------------
  # tcd — adds speaker labels (SPEAKER_00, SPEAKER_01...) to transcripts
  # Uses pyannote.audio (open source, runs fully locally on Apple Silicon).
  # ---------------------------------------------------------------------------
  # BEFORE running this installer on a new machine, you must do the following
  # ONE-TIME manual steps (requires a free HuggingFace account):
  #
  #   1. Create a free account at https://huggingface.co
  #
  #   2. Accept the license for the diarization model:
  #      https://huggingface.co/pyannote/speaker-diarization-3.1
  #
  #   3. Accept the license for the segmentation model (a dependency):
  #      https://huggingface.co/pyannote/segmentation-3.0
  #
  #   4. Create a READ token at https://huggingface.co/settings/tokens
  #      and add it to ~/.zshrc (outside of the dotfiles repo, it's a secret):
  #      export HF_TOKEN="hf_xxxxxxxxxxxxxxxxxxxx"
  #
  # These steps cannot be automated. The models are free but gated behind
  # a license agreement. Once done, they are cached locally and HF is never
  # needed again (until you wipe ~/Library/Caches/huggingface on a new machine).
  # ---------------------------------------------------------------------------
  echo "🐍 Setting up tcd venv (pyannote.audio — this may take a while)..."
  python3 -m venv "$HOME/.venv/tc-diarize"
  "$HOME/.venv/tc-diarize/bin/pip" install --quiet pyannote.audio

  # Remind the user about the manual HF steps
  echo ""
  echo "⚠️  tcd: manual steps required on first use (one-time, per machine):"
  echo "   1. Accept license → https://huggingface.co/pyannote/speaker-diarization-3.1"
  echo "   2. Accept license → https://huggingface.co/pyannote/segmentation-3.0"
  echo "   3. Create a READ token → https://huggingface.co/settings/tokens"
  echo "   4. Add to ~/.zshrc: export HF_TOKEN=\"hf_xxxxxxxxxxxxxxxxxxxx\""
  echo ""

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
ln -sf "$HOME/dotfiles/bin" "$HOME/bin"
mkdir -p "$HOME/.hammerspoon"
ln -sf "$HOME/dotfiles/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"

# ---------------------------------------------------------------------------
# Claude Code — MCP servers
# ---------------------------------------------------------------------------
# MCP (Model Context Protocol) servers are external tools that Claude Code
# can use during conversations (read/write tasks, browse the web, send emails…).
#
# They are registered via `claude mcp add` (writes to ~/.claude.json) or via
# ~/.mcp.json (read automatically by Claude Code at startup).
#
# Each server is a small process that runs ONLY while a Claude Code session
# is active (stdio transport, no daemon, no open port).
#
# The `claude mcp add` commands below are idempotent — re-running them
# overwrites the existing entry with the same config.
#
# Playwright and other marketplace plugins are installed via
# `claude plugin install` and are NOT managed here.
# ---------------------------------------------------------------------------
if command -v claude &>/dev/null; then
  echo "🤖 Registering Claude Code MCP servers..."

  # Things 3 — task manager (read via SQLite, write via Things URL scheme)
  # Requires: Things 3 for macOS, "Enable Things URLs" in Things → Settings → General
  # Package: https://github.com/hald/things-mcp (uvx auto-downloads from PyPI)
  claude mcp add things -s user -- uvx things-mcp
  echo "   ✅ things-mcp"

  # Gmail — send, read, search, reply, manage emails with attachments
  # Custom server: ~/code/gmail-mcp-server (github.com/emirbelkahia/gmail-mcp-server)
  # Requires: one-time OAuth setup — see ~/code/gmail-mcp-server/README.md
  # Registered via ~/.mcp.json (not `claude mcp add`) because it uses an absolute
  # path to a local venv, which is easier to manage in a static JSON file.
  GMAIL_MCP="$HOME/code/gmail-mcp-server"
  if [ -f "$GMAIL_MCP/server.py" ]; then
    # Create venv and install deps if missing
    if [ ! -d "$GMAIL_MCP/.venv" ]; then
      echo "   🐍 Setting up gmail-mcp-server venv..."
      python3 -m venv "$GMAIL_MCP/.venv"
      "$GMAIL_MCP/.venv/bin/pip" install --quiet -r "$GMAIL_MCP/requirements.txt"
    fi
    # Write ~/.mcp.json (Claude Code reads this at startup)
    cat > "$HOME/.mcp.json" <<MCPEOF
{
  "mcpServers": {
    "gmail": {
      "command": "$GMAIL_MCP/.venv/bin/python",
      "args": ["$GMAIL_MCP/server.py"]
    }
  }
}
MCPEOF
    echo "   ✅ gmail-mcp-server (via ~/.mcp.json)"
  else
    echo "   ⏭️  gmail-mcp-server not found at $GMAIL_MCP — skipping"
    echo "      Clone it: git clone git@github.com:emirbelkahia/gmail-mcp-server.git $GMAIL_MCP"
  fi
else
  echo "⏭️  Claude Code not installed — skipping MCP server registration"
fi

echo "✅ Done. Run 'source ~/.zshrc' to apply."
