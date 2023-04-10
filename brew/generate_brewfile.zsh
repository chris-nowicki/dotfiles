#!/usr/bin/env zsh

echo "\n<<< Generating Brewfile >>>"

brew bundle dump --force --describe --file=~/.dotfiles/brew/Brewfile
python3 ~/.dotfiles/brew/parse_brewfile.py
echo "*** Brewfile Generated ***\n"