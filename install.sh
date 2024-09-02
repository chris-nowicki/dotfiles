#!/bin/zsh

# echo "Installing dotfiles..."
echo "Installing dotfiles..."

for dir in */; do
  stow "$dir"
done

# check for .hushlogin file and if it does not exist, create it
if [ ! -f "$HOME/.hushlogin" ]; then
  echo "Creating .hushlogin file..."
  touch "$HOME/.hushlogin"
else
  echo ".hushlogin file already exists."
fi

echo "Done!"
