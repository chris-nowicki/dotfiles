#! /bin/bash

DOTFILES=(.bash_profile .gitconfig .gitignore .zshrc)

for dotfile in $(echo ${DOTFILES[*]});
do
    cp -f ~/Dotfiles/$(echo $dotfile) ~/$(echo $dotfile)
done
