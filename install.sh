#!/bin/zsh

# echo "Installing dotfiles..."
echo "Installing dotfiles..."

for dir in */; do
  stow "$dir"
done

# check for .hushlogin file and if it does not exist, create it
echo "Checking for .hushlogin file..."

if [ ! -f ~/.hushlogin ]; then
  echo "Creating .hushlogin file..."
  touch ~/.hushlogin
fi

echo "Done!"
