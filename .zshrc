export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
export HOMEBREW_NO_ENV_HINTS=1

autoload -U compinit; compinit

plugins=(git zoxide fzf)

source $ZSH/oh-my-zsh.sh

export EDITOR='nano'

# -------
# Aliases
# -------
alias c="clear"
alias cd="z"
alias cm="npx cz"
alias du="~/Dotfiles/config.sh"
alias l="ls" # List files in current directory
alias ll="ls -al" # List all files in current directory in long list format
alias o="open ." # Open the current directory in Finder

# ----------------------
# Git Aliases
# ----------------------
alias gaa='git add .'
alias gcm='git commit -m'
alias gac='git add-commit -m'
alias gpsh='git push'
alias gss='git status -s'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'