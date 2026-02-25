# Environment Variables
export HOMEBREW_NO_ENV_HINTS=1

# NVM Configuration (lazy-loaded for fast shell startup)
export NVM_DIR="$HOME/.nvm"

nvm() {
  unfunction nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() { nvm --version > /dev/null 2>&1; node "$@"; }
npm() { nvm --version > /dev/null 2>&1; npm "$@"; }
npx() { nvm --version > /dev/null 2>&1; npx "$@"; }

# History settings
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias bu="brew upgrade"
alias c="clear"
alias cd="z"
alias ll="eza -l --git --header --git-ignore --icons=always --group-directories-first"
alias lla="eza -laR --git -T --header --git-ignore --ignore-glob=".git" --group-directories-first"
alias ls='eza --icons=always'
alias o="open ."
alias rz="source ~/.zshrc"
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

alias nd="npm run dev"
alias nb="npm run build"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias lg='lazygit'
alias gcw='echo "Cloning work repo:" && git clone $(pbpaste | sed "s/github.com/github-bc/g")'

# Plugins
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.local/bin:$PATH"
