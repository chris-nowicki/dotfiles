# ------------------
# Powerlevel10k
# ------------------
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------
# Zinit Setup
# ------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not present
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ------------------
# Plugins
# ------------------
zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

# NVM setup
export NVM_LAZY_LOAD=true
zinit light lukechilds/zsh-nvm

# ------------------
# History Configuration
# ------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ------------------
# Key Bindings
# ------------------
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ------------------
# Shell Integrations
# ------------------
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# ------------------
# Environment Variables
# ------------------
CASE_SENSITIVE="true"
export HOMEBREW_NO_ENV_HINTS=1

# ------------------
# Aliases
# ------------------
# Folder Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# General
alias c="clear"
alias cd="z"
alias cm="npx cz"
alias ll="eza -l --git --header --git-ignore --icons=always"
alias lla="eza -laR --git -T --header --git-ignore --ignore-glob=".git""
alias ls='eza --icons=always'
alias nv='nvim'
alias o="open ."
alias rz="source ~/.zshrc"
alias zconf="nvim ~/Dotfiles/zsh/.zshrc"

# Git
alias gaa='git add .'
alias gcm='git commit -m'
alias gac='git add-commit -m'
alias gp='git push'
alias gss='git status -s'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'

# ------------------
# Completions
# ------------------
function deferred_compinit() {
  autoload -Uz compinit && compinit
}

precmd_functions+=( deferred_compinit )
