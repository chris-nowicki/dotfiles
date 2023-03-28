[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Aliases
alias ls='ls -lAFh'

# Functions
mkcd () {
  mkdir -p "$@" && cd "$_"
}

# Load Starship
eval "$(starship init zsh)"