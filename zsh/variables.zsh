# Set Variables
# Syntax highlighting for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HOMEBREW_CASK_OPTS="--no-quarantine"
export NVM_DIR="$HOME/.nvm"
NULLCMD=bat
skip_global_compinit=1