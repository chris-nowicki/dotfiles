[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

# Set Variables
# Syntax highlighting for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Add Locations to $PATH Variable
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Aliases
alias ls='exa -laFh --git'
alias exa='exa -laFh --git'
alias bbd="brew bundle dump --force --describe"
alias bnq="python3 args.py"

# Functions
function mkcd () {
  mkdir -p "$@" && cd "$_"
}

function exists() {
  command -v $1 >/dev/null 2>&1
}

# Load Starship
eval "$(starship init zsh)"