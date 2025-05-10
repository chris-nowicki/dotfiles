# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
plugins=(zoxide git nvm)
source $ZSH/oh-my-zsh.sh

# Environment Variables
export HOMEBREW_NO_ENV_HINTS=1

# NVM Configuration
export NVM_LAZY_LOAD=true

# Aliases
# General
alias bu="brew upgrade"
alias c="clear"
alias cd="z"
alias ll="eza -l --git --header --git-ignore --icons=always --group-directories-first"
alias lla="eza -laR --git -T --header --git-ignore --ignore-glob=".git" --group-directories-first"
alias ls='eza --icons=always'
alias nv='nvim'
alias o="open ."
alias rz="source ~/.zshrc"
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

# Development
alias nd="npm run dev"
alias nb="npm run build"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias lg='lazygit'

# Herd PHP Configuration
export PATH="/Users/chris/Library/Application Support/Herd/bin/":$PATH
export HERD_PHP_83_INI_SCAN_DIR="/Users/chris/Library/Application Support/Herd/config/php/83/"
