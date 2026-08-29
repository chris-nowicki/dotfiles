#!/bin/zsh

set -e # Exit on error

# Activate the nix-darwin + home-manager configuration for this machine.
# Prereqs: Nix installed (Determinate), an SSH key created, this repo cloned.
# See README.md for the full new-machine bootstrap.

HOST="${1:-$(scutil --get LocalHostName)}"
FLAKE="${HOME}/Dotfiles#${HOST}"

echo "Activating config for host: ${HOST}"

if [ -e /run/current-system/sw/bin/darwin-rebuild ]; then
  # nix-darwin already bootstrapped — normal switch.
  sudo /run/current-system/sw/bin/darwin-rebuild switch --flake "$FLAKE"
else
  # First run — bootstrap nix-darwin (installs darwin-rebuild).
  echo "First run: bootstrapping nix-darwin..."
  sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake "$FLAKE"
fi

# Suppress the login banner.
[ -f "$HOME/.hushlogin" ] || touch "$HOME/.hushlogin"

echo "Done!"
