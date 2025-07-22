# Load Starship CLI
eval "$(starship init zsh)"

# Environment Variables
export HOMEBREW_NO_ENV_HINTS=1

# NVM Configuration
export NVM_LAZY_LOAD=true

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Aliases
# General
alias bu="brew upgrade"
alias c="clear"
alias cd="z"
alias ll="eza -l --git --header --git-ignore --icons=always --group-directories-first"
alias lla="eza -laR --git -T --header --git-ignore --ignore-glob=".git" --group-directories-first"
alias ls='eza --icons=always'
alias o="open ."
alias rz="source ~/.zshrc"
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

# Development
alias nd="npm run dev"
alias nb="npm run build"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias lg='lazygit'
alias gcw='echo "Cloning work repo:" && git clone $(pbpaste | sed "s/github.com/github-bc/g")'

# Herd PHP Configuration
export PATH="/Users/chris/Library/Application Support/Herd/bin/":$PATH

# Zsh Plugins
eval "$(zoxide init zsh)"
