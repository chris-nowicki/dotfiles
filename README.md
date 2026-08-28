# My Dotfiles

Personal macOS configuration for two Macs (a work laptop and a personal machine),
managed declaratively with **[nix-darwin](https://github.com/nix-darwin/nix-darwin)**
+ **[home-manager](https://github.com/nix-community/home-manager)** in one flake.

One `darwin-rebuild switch` reproduces the whole setup: system settings,
Homebrew apps, and dotfiles.

## Prerequisites

> [!IMPORTANT]
> Follow the [mac-setup](https://github.com/chris-nowicki/mac-setup) guide first.

- **Nix** via the [Determinate Systems installer](https://install.determinate.systems)
  (flakes enabled by default):
  ```sh
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```

## New-machine bootstrap

1. `xcode-select --install`, then install Nix (above).
2. Create a fresh SSH key (one per machine — never copy keys):
   ```sh
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal   # work laptop's personal key
   # (personal machine uses ~/.ssh/id_ed25519; work laptop also has ~/.ssh/id_ed25519_bc)
   ```
   Add the `.pub` to GitHub, then `ssh -T git@github.com`.
3. Clone this repo (HTTPS the first time to avoid the SSH chicken-and-egg):
   ```sh
   git clone https://github.com/chris-nowicki/dotfiles.git ~/Dotfiles
   ```
4. Activate:
   ```sh
   cd ~/Dotfiles && ./install.sh          # or the explicit command below
   sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/Dotfiles#<LocalHostName>
   ```

## Daily use

```sh
# Apply changes (system + Homebrew + dotfiles) after editing any config:
sudo darwin-rebuild switch --flake ~/Dotfiles#<LocalHostName>
# or: ./install.sh

# Roll back a bad switch:
sudo darwin-rebuild switch --rollback
```

`<LocalHostName>` = `scutil --get LocalHostName` (the work laptop is `C7Q95C63WW`).

## Structure

```
flake.nix                  # inputs + darwinConfigurations (per machine)
darwin/
  common.nix               # nix settings, Touch ID sudo, Homebrew (casks/brews/taps)
  hosts/work-laptop.nix     # this machine's apps + work-only bits
home/
  common.nix               # home-manager: packages + static config symlinks
  hosts/work-laptop.nix     # work git email (~/code/commerce/), SSH keys, gcw/gcwm
  hosts/personal.nix        # personal machine's identity/SSH (used once it's set up)
modules/
  zsh.nix  git.nix          # shell + git config
starship/  ghostty/         # config files symlinked by home-manager
```

## Notes

- **Node** is managed by `nvm` (not Nix); `brew shellenv` + nvm are preserved in
  the login shell.
- **SSH keys** are never managed by Nix (they're secrets) — only `~/.ssh/config`
  is generated.
- The personal machine still needs its own `darwinConfigurations` entry.
