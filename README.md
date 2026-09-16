# My Dotfiles 🧊

My Mac setup: apps, terminal configs, shell, Git, SSH config, and macOS preferences.
Edit the files here, then run `./switch.sh` to apply them to this Mac.

- [Set up a new Mac](#set-up-a-new-mac)
- [Change a config or preference](#change-a-config-or-preference)
- [Add or remove software](#add-or-remove-software)
- [Upgrade software](#upgrade-software)
- [Bring changes to the other Mac](#bring-changes-to-the-other-mac)
- [If something goes wrong](#if-something-goes-wrong)

## Set up a new Mac

These configurations target **Apple Silicon** Macs. Nix installs the configured
software and settings; account sign-ins, private keys, app permissions, and
personal files still need separate setup.

### 1. Install the prerequisites

In Terminal, install Apple's command line tools and wait for installation to finish:

```sh
xcode-select --install
```

Install [Homebrew](https://docs.brew.sh/Installation), then follow its printed
instructions to add `brew` to your shell:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install [Determinate Nix](https://determinate.systems/install/) using its macOS
installer. Open a new terminal and confirm `nix --version` and `brew --version`
work. This repo expects Determinate to manage the Nix installation.

### 2. Clone this repo

HTTPS works before SSH keys are configured:

```sh
git clone https://github.com/chris-nowicki/dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

### 3. Match the configuration to the machine

Check the machine name and account name:

```sh
scutil --get LocalHostName
whoami
```

| Profile | Machine name | Account |
|---------|--------------|---------|
| Personal | `Wixys-MacBook-Pro` | `wix` |
| Work | `C7Q95C63WW` | `chris.nowicki` |

If both match an existing profile, continue to step 4. Otherwise, create a branch
with `git switch -c feat/new-machine` and adjust the configuration first:

- In `flake.nix`, rename the matching machine entry if replacing that Mac, or copy
  its `mkDarwin` entry if adding another Mac. Use the new machine name as its key.
- If the account differs, update `user` in that entry, `system.primaryUser` and
  `users.users.<account>.home` in its `darwin/hosts/` file, and
  `home.homeDirectory` in its `home/hosts/` file.
- When adding a Mac that needs different settings, copy the two host files and
  point the new entry at them, preserving the existing Mac's configuration.

Review the host's app list and, for work machines, the email, repository folder,
SSH keys, and aliases in `home/hosts/work-laptop.nix` before applying it.

### 4. Create this Mac's SSH keys

For a personal Mac:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

For a work Mac:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_bc
```

Add each `.pub` key to its corresponding GitHub account. Keep private keys out of
this repo. If restoring a machine with existing keys, don't overwrite them.

### 5. Build and apply

From `~/Dotfiles`, stage any new configuration files with `git add <file>` so Nix
can see them. Then:

```sh
nix build ".#darwinConfigurations.$(scutil --get LocalHostName).system" --no-link
./switch.sh
```

The first command checks the build without changing your active setup. The second
asks for sudo authentication and applies everything, bootstrapping nix-darwin on
first use. Homebrew itself must already be installed.

Open a new terminal. Test `ssh -T git@github.com` and, on a work Mac,
`ssh -T git@github-bc` now that the generated SSH config exists. GitHub should
identify the correct account (its successful authentication message still exits
with status 1). Enable pushing over SSH:

```sh
git remote set-url origin git@github.com:chris-nowicki/dotfiles.git
```

Commit any machine-specific changes on your feature branch and open a PR.

### 6. Finish the manual setup

- Sign into apps, activate licenses, restore your files, and grant requested app
  permissions. Configure Raycast/AltTab shortcuts and other app-specific settings.
- Install [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) and the Node
  versions your projects need; Node is not installed by this configuration.
- Install any extra or App Store apps you still need; the old `~/Setup` guide
  lists apps beyond those currently managed here.
- In System Settings, turn off **AutoFill Passwords and Passkeys**, and hide
  **Spotlight** and **Siri** from the menu bar. Labels vary by macOS version.
- Check Dock, Finder, widgets, and the clock. Log out and back in if changes
  haven't appeared.

## Change a config or preference

Start from an up-to-date `main` with a clean working tree, then create a branch:

```sh
cd ~/Dotfiles
git switch main
git pull --ff-only
git switch -c chore/my-config-change
```

Edit the source file in this repo:

| Change | File |
|--------|------|
| Ghostty font, theme, opacity | `ghostty/.config/ghostty/config` |
| Starship prompt | `starship/.config/starship.toml` |
| Shell aliases or behavior | `modules/zsh.nix` |
| Dock, Finder, scrolling, desktop, clock | `darwin/macos.nix` |
| Personal Git identity | `modules/git.nix` |
| Work Git identity, SSH, clone aliases | `home/hosts/work-laptop.nix` |
| Personal SSH config | `home/hosts/personal.nix` |

**Edit the repo copy.** The live Ghostty and Starship files under `~/.config` are
read-only links to the applied configuration.

After editing, stage any newly created files with `git add <file>`, then:

```sh
nix build ".#darwinConfigurations.$(scutil --get LocalHostName).system" --no-link
./switch.sh
```

Check the result before committing and opening a PR:

- **Ghostty:** [reload with `Cmd+Shift+,`](https://ghostty.org/docs/config).
- **Starship or shell:** open a new terminal.
- **macOS preferences:** inspect the affected setting; log out/in if needed.

Shared files affect both Macs when each runs `./switch.sh`. For a macOS preference
on only one Mac, override it in `darwin/hosts/<host>.nix` using `lib.mkForce`
(add `lib` to that module's arguments).

Preferences changed directly in System Settings are overwritten on the next
switch if Nix manages them. Removing an option stops managing it but leaves its
last value in place; set your desired replacement explicitly.

## Add or remove software

Choose the appropriate list:

| Software | File and list |
|----------|---------------|
| GUI apps or fonts on both Macs | `darwin/common.nix` → `homebrew.casks` |
| GUI apps on just one Mac | `darwin/hosts/personal.nix` or `work-laptop.nix` → `homebrew.casks` |
| Most command line tools | `home/common.nix` → `home.packages` |
| Homebrew-only command line tools | Shared or host-specific `homebrew.brews` |

**Add:** add the package to its list, then follow the build → switch → verify → PR
workflow above. Homebrew casks/formulae are quoted strings; Nix packages use the
package attribute name. Custom-tap packages need their tap in `homebrew.taps` and
the full name, such as `"aprilnea/tap/openlogi@latest"`.

**Remove a Nix tool:** remove it from `home.packages`, build, and switch. It leaves
the active environment; another separately installed copy may still exist.

**Remove a Homebrew app or tool:** remove it from every applicable list, build,
and switch, then uninstall it on each Mac where it is no longer wanted:

```sh
brew uninstall --cask <app-name>
# Or, for a command line tool:
brew uninstall <formula-name>
```

Homebrew cleanup is intentionally disabled, so deleting a list entry alone does
not uninstall software. Uninstalling without editing the list lets the next
switch install it again.

## Upgrade software

Changing settings doesn't require upgrading packages.

- **Homebrew:** run `brew update`, then `brew upgrade <name>` for a specific app
  or tool (or `brew upgrade` for all eligible packages). Switching does not
  automatically upgrade installed Homebrew packages.
- **Nix tools/modules:** on a feature branch, run `nix flake update`, then build,
  switch, and verify as above. Commit `flake.lock` with the update. This updates
  all pinned inputs, including nix-darwin and home-manager.
- **Node:** update separately through nvm.

## Bring changes to the other Mac

After the PR is merged, use a clean working tree on the other Mac:

```sh
cd ~/Dotfiles
git switch main
git pull --ff-only
nix build ".#darwinConfigurations.$(scutil --get LocalHostName).system" --no-link
./switch.sh
```

Only that Mac's profile is applied. Homebrew removals still need the manual
uninstall step there too.

## If something goes wrong

- **Build fails:** fix the error before switching; the active setup is unchanged.
- **Unknown hostname:** check the entries in `flake.nix`. You can explicitly
  select one with `./switch.sh Wixys-MacBook-Pro`, but its account/home paths must
  match the machine you're applying it to.
- **A change causes problems:** revert the source change and switch again, or use
  `sudo /run/current-system/sw/bin/darwin-rebuild switch --rollback` to return to
  the previous generation. Homebrew changes are not undone by a Nix rollback.
- **A macOS preference stays changed after rollback:** a generation that never
  managed the key won't remove it. Restore its previous value, or use
  `defaults delete <domain> <key>` if it was previously absent, and remove the
  corresponding Nix option before switching again.
