# === HOMEBREW ===
eval "$(/opt/homebrew/bin/brew shellenv)"

# === NODE ===
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# === BUN ===
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/emir.belkahia/.bun/_bun" ] && source "/Users/emir.belkahia/.bun/_bun"

# === PATH ===
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/emir.belkahia/.antigravity/antigravity/bin:$PATH"

# === ALIASES ===
alias python="python3"
alias cat="bat"
alias grep="rg"
alias top="btop"
alias ls="eza"
alias ll="eza -la"
alias find="fd"
alias claude-mem='bun "/Users/emir.belkahia/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# === TOOLS ===
eval "$(zoxide init zsh)"

# === LOCAL (secrets, overrides) ===
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
