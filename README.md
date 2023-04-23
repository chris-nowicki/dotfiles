# Chris Nowicki's Dot Files

I'm learning a ton about [dotfiles, command line use, Homebrew, zsh, git, macOS and more with the course ***Dotfiles from Start to Finish-ish***](http://dotfiles.eieio.xyz/) by [@EIEIOxyz](https://twitter.com/EIEIOxyz/), and you can too!

## Steps to bootstrap a new Mac

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```zsh
xcode-select --install
```

2. Clone repo into new hidden directory.

```zsh
# Use SSH (if set up)...
git clone git@github.com:chris-nowicki/dotfiles.git ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/chris-nowicki/dotfiles.git ~/.dotfiles
```
3. run the dotbot install script to install home brew, Brewfiles, App Store Apps, and configure MacOS settings.
```zsh
# change to the hidden dotfiles directory
cd ~/.dotfiles

# run the dotbot install script
./install
```

## TODO List

- [X] Learn how to use [`defaults`](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command) to record and restore System Preferences and other macOS configurations.
- [X] Organize these growing steps into multiple script files.
- [X] Automate symlinking and run script files with a bootstrapping tool like [Dotbot](https://github.com/anishathalye/dotbot).
- [ ] Make a checklist of steps to decommission your computer before wiping your hard drive.
- [ ] Create a [bootable USB installer for macOS](https://support.apple.com/en-us/HT201372).
- [X] Integrate other cloud services into your Dotfiles process (Dropbox, Google Drive, etc.).
- [ ] Find inspiration and examples in other Dotfiles repositories at [dotfiles.github.io](https://dotfiles.github.io/).
- [ ] Share this repo with a million people.
