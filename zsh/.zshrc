# Environment Variables
export HOMEBREW_NO_ENV_HINTS=1

# Dedupe PATH entries automatically
typeset -U path PATH

# Completion system
autoload -Uz compinit && compinit

# Volta (Node version manager)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# History settings
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
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
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -l --git --header --git-ignore --icons=always --group-directories-first'
alias lla='eza -la --git -T --header --git-ignore --ignore-glob=".git" --group-directories-first'
alias rz="source ~/.zshrc"
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias nd="npm run dev"
alias nb="npm run build"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias lg='lazygit'
alias gcw='echo "Cloning work repo:" && git clone $(pbpaste | sed "s/github.com/github-bc/g")'
alias gcwm='echo "Mirroring work repo:" && git clone --mirror $(pbpaste | sed "s/github.com/github-bc/g")'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gbd='git branch -d'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpu='git push -u origin HEAD'
alias gl='git pull'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gd='git diff'
alias gds='git diff --staged'
alias glog='git log --oneline --graph --decorate'
alias gst='git stash'
alias gstp='git stash pop'
alias gcl='git clone'
alias gm='git merge'
alias gr='git rebase'
alias gri='git rebase -i'

# Plugins
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.local/bin:$PATH"
