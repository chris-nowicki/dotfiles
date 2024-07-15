#!/bin/zsh

# echo "Installing dotfiles..."
echo "Installing dotfiles..."

for dir in */; do
  stow "$dir"
done

# check for .hushlogin file and if it does not exist, create it
echo "Checking for .hushlogin file..."

# check if hushlogin exists in the root direcotry and if it does not exist, create it
if [ ! -f "$HOME/.hushlogin" ]; then
  echo "Creating .hushlogin file..."
  touch "$HOME/.hushlogin"
fi

echo "Done!"
