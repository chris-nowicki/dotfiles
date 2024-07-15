#!/bin/zsh

for dir in */; do
  stow "$dir"
done
