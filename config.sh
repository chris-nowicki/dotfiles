#! /bin/bash

DOTFILES=(.bash_profile .gitconfig .gitignore .zshrc)

for dotfile in $(echo ${DOTFILES[*]});
do
    cp -f ~/Dotfiles/$(echo $dotfile) ~/$(echo $dotfile)
done

# Link custom dictionary to cspell
mkdir -p ~/.cspell && ln -s ~/Dotfiles/custom-dictionary-user.txt ~/.cspell/custom-dictionary-user.txt 2>/dev/null

echo "dotfile config complete!"