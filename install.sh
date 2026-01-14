#!/bin/zsh

set -e  # Exit on error

echo "Installing dotfiles..."

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo "Error: GNU Stow is not installed."
  echo "Install it with: brew install stow"
  exit 1
fi

# Install dotfiles using stow
for dir in */; do
  # Skip if directory is empty or doesn't contain files
  if [ -z "$(find "$dir" -type f ! -name '.DS_Store' 2>/dev/null)" ]; then
    echo "Skipping empty directory: $dir"
    continue
  fi
  
  # Remove trailing slash for stow
  dir_name="${dir%/}"
  echo "Stowing $dir_name..."
  
  if ! stow "$dir_name"; then
    echo "Error: Failed to stow $dir_name"
    exit 1
  fi
done

# Check for .hushlogin file and create it if it doesn't exist
if [ ! -f "$HOME/.hushlogin" ]; then
  echo "Creating .hushlogin file..."
  touch "$HOME/.hushlogin"
else
  echo ".hushlogin file already exists."
fi

echo "Done!"
