#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

# install the homebrew application
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --verbose 