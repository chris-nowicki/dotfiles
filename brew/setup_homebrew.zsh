#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

# check if xcode-select is installed
# if not then install it
echo "## checking if xcode-select is installed"
if exists xcode-select; then
  echo "## xcode-select exists, skipping install...\n"
else
  echo "## xcode-select does not exist, continuing with install...\n"
  # install xcode-select
  xcode-select --install
fi

# check to see if homebrew is installed
# if not then install it
echo "## checking if brew is installed"
if exists brew; then
  echo "## brew exists, skipping install...\n"
else
  echo "## brew does not exist, continuing with install...\n"
  # install the homebrew application
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "## installing/updating brews & casks\n"
# Install / Update brews & casks based using a Brewfile
brew bundle -v --file=~/.dotfiles/brew/Brewfile
echo "\n"