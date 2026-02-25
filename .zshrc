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
alias ls="eza --icons=always --group-directories-first"
alias ll="eza -la --icons=always --group-directories-first --git"
alias find="fd"
alias claude-mem='bun "/Users/emir.belkahia/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# === TOOLS ===
eval "$(zoxide init zsh)"

# === PROMPT ===
setopt PROMPT_SUBST
unset RPROMPT

_prompt_env_segment() {
  if [[ -n "${VIRTUAL_ENV:-}" ]]; then
    print -n " (%F{220}${VIRTUAL_ENV:t}%f)"
  elif [[ -n "${CONDA_DEFAULT_ENV:-}" ]]; then
    print -n " (%F{220}${CONDA_DEFAULT_ENV}%f)"
  fi
}

PROMPT=$'\n''%F{45}%~%f$(_prompt_env_segment)\n%F{244}>%f '

# === LOCAL (secrets, overrides) ===
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
