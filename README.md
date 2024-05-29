# My Dot Files

This directory contains the dotfiles for my system

## Prerequisites
> [!IMPORTANT]
> Follow steps to setup a new mac [here](https://github.com/chris-nowicki/mac-setup) before continuing to install dotfiles below.

### Stow

Ensure **GNU STOW** is installed

```sh
brew install stow
```

## Installation

### lone repo:

```zsh
# Use SSH (if set up)...
git clone git@github.com:chris-nowicki/dotfiles.git ~/Dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/chris-nowicki/dotfiles.git ~/Dotfiles
```

### Use **GNU** stow to create symlinks:

```zsh
# Change to the Dotfiles directory
cd ~/Dotfiles

# run the GNU script
stow .
```

## TODO List

- [ ] Make a checklist of steps to decommission your computer before wiping your hard drive.
- [ ] Create a [bootable USB installer for macOS](https://support.apple.com/en-us/HT201372).