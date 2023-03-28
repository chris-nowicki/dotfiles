[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Set Variables
# Syntax highlighting for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Dracula"

# Aliases
alias ls='ls -lAFh'

# Functions
mkcd () {
  mkdir -p "$@" && cd "$_"
}

# Load Starship
eval "$(starship init zsh)"