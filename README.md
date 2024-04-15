# Chris Nowicki's Dot Files

## Prerequisites
> [!CAUTION]
> Follow steps to setup a new mac [here](https://github.com/chris-nowicki/mac-setup) before continuing to install dotfiles below.

## Steps to install dotfiles

1. Clone repo into new hidden directory:

```zsh
# Use SSH (if set up)...
git clone git@github.com:chris-nowicki/dotfiles.git ~/Dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/chris-nowicki/dotfiles.git ~/.dotfiles
```

2. run the `config.sh` script:

```zsh
# change to the hidden dotfiles directory
cd ~/Dotfiles

# run the dotbot install script
./config.sh
```

## TODO List

- [ ] Make a checklist of steps to decommission your computer before wiping your hard drive.
- [ ] Create a [bootable USB installer for macOS](https://support.apple.com/en-us/HT201372).