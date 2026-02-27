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
alias find="fd"
alias claude-mem='bun "/Users/emir.belkahia/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
alias claude-sonnet='claude --model sonnet --dangerously-skip-permissions'
alias claude-haiku='claude --model haiku --dangerously-skip-permissions'
alias claude-opus='claude --model opus --dangerously-skip-permissions'

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=auto --group-directories-first"
  alias ll="eza -la --icons=auto --group-directories-first --git"
else
  alias ls="ls -F"
  alias ll="ls -laF"
fi

# === TOOLS ===
eval "$(zoxide init zsh)"

# Don't let venv modify the prompt (handled manually below)
export VIRTUAL_ENV_DISABLE_PROMPT=1

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

PROMPT=$'\n%F{45}%~%f$(_prompt_env_segment)\n%F{244}>%f '

# === LOCAL (secrets, overrides) ===
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
