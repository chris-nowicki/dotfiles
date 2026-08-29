---
name: apply-config
description: Apply a change to the ~/Dotfiles Nix config (nix-darwin + home-manager) and land it safely — dry-build, switch, verify, commit. Use when the user wants to add or remove a Homebrew app/cask, add a CLI tool, add a shell alias, change git identity, or edit ghostty/starship config — anything that needs a darwin-rebuild switch.
---

# Apply a config change

Make a change to `~/Dotfiles` and **land** it. A change isn't landed until it's
dry-built, switched, verified in a fresh shell, and committed — a green switch
alone is not done.

## Steps

1. **Find the file.** Identify the exact file + attribute to edit from the
   "Common edits — where to change what" table in `~/Dotfiles/README.md`.

2. **Edit the source in the repo** — always the file under `~/Dotfiles/…`, never
   the live `~/.config/…` path (those are read-only Nix-store symlinks).

3. **Stage it:** `cd ~/Dotfiles && git add -A`. Flakes only see git-tracked
   files — an unstaged file is invisible to the build.

4. **Dry-build** (no sudo; catches evaluation errors):
   ```sh
   nix build ~/Dotfiles#darwinConfigurations.$(scutil --get LocalHostName).system --no-link
   ```
   Landed step: exits 0, no evaluation error, no warning you introduced.

5. **Switch:** `./switch.sh`. Watch the Homebrew step for an interactive
   `[y/n]` — if it wants to uninstall something unexpected, answer **no** and fix
   the manifest (see Gotchas).

6. **Verify in a fresh login shell** that the change took effect — check the
   specific thing you changed:
   ```sh
   env -i HOME="$HOME" USER="$USER" TERM=xterm SHELL=/bin/zsh /bin/zsh -lic '<check>'
   ```
   e.g. the alias resolves, `command -v <tool>` points into Nix, the app is in
   `/Applications`, `git config user.email` is correct.

7. **Commit** with a conventional message and no Claude attribution, e.g.
   `git commit -m "feat(nix): add <thing>"`.

## Gotchas

- **Tap casks** need the full `tap/name` in `homebrew.casks` **and** the tap in
  `homebrew.taps` — a short name gets wrongly uninstalled.
- **`homebrew.onActivation.cleanup` stays `"none"`.** To remove an app, delete it
  from the list **and** run `brew uninstall <app>` yourself. Don't flip to
  `"uninstall"`.
- **CLI tools go to Nix** (`home.packages` in `home/common.nix`), not brew.
  **Node stays on nvm**, not Nix.
- **Hostname = config key.** If `scutil --get LocalHostName` changes, the
  `darwinConfigurations` key must match (README → hostname changes).
