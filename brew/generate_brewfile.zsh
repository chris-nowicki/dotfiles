#!/usr/bin/env zsh

echo "\n<<< Generating Brewfile >>>"

brew bundle dump --force --describe > ~/.dotfiles/brew/Brewfile
python3 ~/.dotfiles/brew/parse_brewfile.py
# mv ~/.dotfiles/Brewfile ~/.dotfiles/brew/
echo "*** Brewfile Generated ***\n"