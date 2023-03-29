[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Set Variables
# Syntax highlighting for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Dracula"
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Add Locations to $PATH Variable
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Aliases
alias ls='exa -laFh --git'
alias exa='exa -laFh --git'

# Functions
mkcd () {
  mkdir -p "$@" && cd "$_"
}

# Load Starship
eval "$(starship init zsh)"

