# My Dotfiles 🧊

Personal **macOS** configuration for two Macs, managed declaratively with
**[Nix](https://nixos.org)** — no more hand-installed apps, no config drift,
reproducible on a fresh machine in one command.

Built from three layers:

| Layer | Tool | Manages |
|-------|------|---------|
| 🖥️ **System** | [nix-darwin](https://github.com/nix-darwin/nix-darwin) | Homebrew apps, macOS settings, Touch ID sudo |
| 🏠 **User** | [home-manager](https://github.com/nix-community/home-manager) | dotfiles, shell, git, ssh, CLI tools |
| 📦 **Base** | [Nix flakes](https://nixos.wiki/wiki/Flakes) | pins every dependency to an exact version |

home-manager is folded **into** nix-darwin, so a single `sudo darwin-rebuild
switch` applies system + apps + dotfiles together.

> 💡 New to Nix? Open `~/Downloads/nix-setup-guide.html` for the visual explainer.

---

## Table of Contents

- [How it works](#how-it-works)
- [Repository structure](#repository-structure)
- [Daily use](#daily-use)
- [Making changes with Claude](#making-changes-with-claude)
- [New machine setup](#new-machine-setup)
  - [Personal machine](#personal-machine)
  - [Work machine](#work-machine)
- [Work scenarios (new job, new machine, email/host changes)](#work-scenarios)
- [Identities & SSH keys](#identities--ssh-keys)
- [Adding & removing apps (Homebrew)](#adding--removing-apps-homebrew)
- [Common edits — where to change what](#common-edits--where-to-change-what)
- [Troubleshooting](#troubleshooting)

---

## How it works

You **describe** the machine you want in Nix files; `darwin-rebuild switch`
**makes the machine match**. Nothing is installed by clicking around — if it
isn't in the config, it isn't on the machine (and vice-versa).

- **Declarative** — the files are the source of truth.
- **Reproducible** — the same config → the same machine, every time.
- **Reversible** — every switch is a generation you can roll back to.

Each machine is a named **`darwinConfiguration`** keyed by its hostname
(`scutil --get LocalHostName`). The work laptop is `C7Q95C63WW`.

---

## Repository structure

```
flake.nix                    # inputs (nixpkgs, home-manager, nix-darwin) + darwinConfigurations
darwin/
  common.nix                 # nix settings, Touch ID sudo, Homebrew engine, primaryUser
  hosts/work-laptop.nix      # this machine's casks / brews / taps
home/
  common.nix                 # home.packages + static config symlinks (starship, ghostty)
  hosts/work-laptop.nix      # work git email, SSH keys, work-only aliases (gcw/gcwm)
  hosts/personal.nix         # personal identity/SSH (used once that machine exists)
modules/
  zsh.nix                    # aliases, history, plugins, PATH, brew+nvm, gone()
  git.nix                    # base (personal) git identity + settings
starship/ ghostty/           # verbatim config files, symlinked by home-manager
switch.sh                    # thin wrapper → darwin-rebuild switch for this host
```

> [!NOTE]
> **Node** is intentionally managed by `nvm`, not Nix. **SSH private keys** are
> never in Nix (they're secrets) — only `~/.ssh/config` is generated.

---

## Daily use

```sh
# After editing any config, apply everything (system + apps + dotfiles):
sudo darwin-rebuild switch --flake ~/Dotfiles#C7Q95C63WW
# shortcut (auto-detects the host name):
cd ~/Dotfiles && ./switch.sh

# Preview a build without activating (do this first if unsure):
nix build ~/Dotfiles#darwinConfigurations.C7Q95C63WW.system --no-link

# Undo the last switch:
sudo darwin-rebuild switch --rollback
```

> [!TIP]
> Flakes only see **git-tracked** files. `git add` new files before building or
> Nix won't find them.

---

## Making changes with Claude

This repo ships an **`apply-config`** [skill](.claude/skills/apply-config/SKILL.md)
for [Claude Code](https://claude.com/claude-code). Run Claude Code inside
`~/Dotfiles`, ask for a config change, and it follows the safe loop automatically:
**edit the source → dry-build → `./switch.sh` → verify in a fresh shell → commit.**

Just say what you want (or type `/apply-config`):

| You say… | It edits | and verifies |
|---|---|---|
| "add Slack to my apps" | `homebrew.casks` in `darwin/hosts/work-laptop.nix` | app installed in `/Applications` |
| "bump my ghostty font size to 20" | `ghostty/.config/ghostty/config` | reload Ghostty (`Cmd+Shift+,`) |
| "add an alias `k` for kubectl" | `shellAliases` in `modules/zsh.nix` | alias resolves in a fresh shell |
| "add ripgrep as a CLI tool" | `home.packages` in `home/common.nix` (Nix, not brew) | `command -v rg` → Nix |
| "change my work email to me@newco.com" | `programs.git.includes` in `home/hosts/work-laptop.nix` | `git config user.email` under `~/code/commerce/` |

It handles the gotchas for you — dry-build before switching, tap-qualified casks,
editing the repo source (not the read-only live symlink), and verifying the change
took effect before calling it done.

---

## New machine setup

Same 4 steps for either machine. The only differences are the SSH key name and
which config you activate.

> [!NOTE]
> **"How do I get the repo before SSH is set up?"** You don't need SSH for that.
> This repo is **public**, so you `git clone` it over **HTTPS** — no key, no
> login. SSH keys are only for *pushing* changes and for the generated
> `~/.ssh/config`; the clone itself never touches them. So the order is:
> **clone over HTTPS → create your key → `switch`.** Afterward, point the remote
> at SSH so you can push:
> `git remote set-url origin git@github.com:chris-nowicki/dotfiles.git`.

### 0. Prerequisites (both)

1. Run the [mac-setup](https://github.com/chris-nowicki/mac-setup) guide.
2. `xcode-select --install`
3. Install Nix (Determinate — flakes on by default):
   ```sh
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
   Then **open a new terminal**.

### Personal machine

The config entry already exists — host **`Wixys-MacBook-Pro`**, user **`wix`** — so
it's just bootstrap:

```sh
# 1. Create the personal SSH key (default name on the personal Mac)
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
#    → add ~/.ssh/id_ed25519.pub to GitHub, then: ssh -T git@github.com

# 2. Clone the branch (until it's merged to main)
git clone -b feat/nix-home-manager https://github.com/chris-nowicki/dotfiles.git ~/Dotfiles

# 3. First activation — additive (cleanup="none"), so it won't remove anything
cd ~/Dotfiles
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#Wixys-MacBook-Pro
```

The first switch adopts your already-installed apps and installs the shared ones
you don't have yet (capcut, chatgpt, obsidian, openlogi, wispr-flow, some fonts).

### Work machine

```sh
# 1. Create BOTH keys this machine uses
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal   # personal GitHub
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_bc         # work GitHub
#    → add both .pub keys to their GitHub accounts; test:
#    ssh -T git@github.com   and   ssh -T git@github-bc

# 2. Clone (HTTPS first time)
git clone https://github.com/chris-nowicki/dotfiles.git ~/Dotfiles

# 3. Activate (first run bootstraps nix-darwin)
cd ~/Dotfiles
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#$(scutil --get LocalHostName)
```

If the new machine's hostname differs from `C7Q95C63WW`, see
[Work scenarios → new machine](#new-work-machine).

---

## Work scenarios

Everything work-specific lives in **two files**:
`home/hosts/work-laptop.nix` (identity + SSH) and
`darwin/hosts/work-laptop.nix` (apps). Here's what to touch for each situation.

### New job (same machine, new employer)

You'll typically get a new email, a new git host, and new repos. Edit
`home/hosts/work-laptop.nix`:

1. **Work email** — in the `programs.git.includes` block:
   ```nix
   contents.user.email = "you@newcompany.com";
   ```
2. **Where work repos live** — change the include condition to the new folder:
   ```nix
   condition = "gitdir:~/code/newco/";
   ```
3. **New work SSH key**:
   ```sh
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_newco   # add .pub to their GitHub/GitLab
   ```
4. **New git host alias** — rename the `github-bc` block in `programs.ssh.settings`
   (and point it at the new key). If the new employer uses GitLab/Bitbucket,
   change `HostName` too:
   ```nix
   "git-newco" = {
     HostName = "github.com";           # or gitlab.com, etc.
     IdentityFile = "~/.ssh/id_ed25519_newco";
     AddKeysToAgent = "yes"; IdentitiesOnly = "yes"; UseKeychain = "yes";
   };
   ```
5. **Clone helpers** — the `gcw`/`gcwm` aliases rewrite `github.com` → `github-bc`;
   update that `sed` pattern if your host alias changed.
6. `sudo darwin-rebuild switch --flake .#C7Q95C63WW`

> [!TIP]
> Leave the old job's block in place if you still push to it; remove it once
> you've fully moved. Nothing breaks by keeping an unused host alias.

### New work machine

1. Do the [Work machine](#work-machine) bootstrap (fresh keys, clone).
2. In `flake.nix`, either **rename** the existing entry or **add** a new one for
   the new hostname:
   ```nix
   darwinConfigurations."<NEW_HOSTNAME>" = nix-darwin.lib.darwinSystem {
     modules = [ ./darwin/common.nix ./darwin/hosts/work-laptop.nix
                 home-manager.darwinModules.home-manager
                 { home-manager = { /* …same block… */
                     users."chris.nowicki".imports =
                       [ ./home/common.nix ./home/hosts/work-laptop.nix ]; }; } ];
   };
   ```
   Get the hostname with `scutil --get LocalHostName`.
3. If the new machine uses different app or key names, give it its own host files
   under `darwin/hosts/` and `home/hosts/` instead of reusing `work-laptop.nix`.

### Work email changes (rebrand / promotion)

One line in `home/hosts/work-laptop.nix` → the `contents.user.email` in the
`programs.git.includes` block → `sudo darwin-rebuild switch …`.

### Machine ID (hostname) changes

The `darwinConfigurations` key **must match** `scutil --get LocalHostName`, or
`switch` errors with *"does not provide attribute … Did you mean …?"*.

- **Fix:** rename the key in `flake.nix` to the new name, or just pass the new
  name explicitly: `--flake .#<new-name>`.
- **Prevent it:** pin the name so macOS can't drift it — add to `darwin/common.nix`:
  ```nix
  networking.hostName = "C7Q95C63WW";
  networking.localHostName = "C7Q95C63WW";
  ```

---

## Identities & SSH keys

| | Work laptop (`C7Q95C63WW`) | Personal machine |
|---|---|---|
| **Default git identity** | personal (noreply) | personal |
| **Work identity** | `chris.nowicki@bigcommerce.com`, scoped to `~/code/commerce/` | — |
| **Personal SSH key** | `~/.ssh/id_ed25519_personal` (→ `github.com`) | `~/.ssh/id_ed25519` (→ `github.com`) |
| **Work SSH key** | `~/.ssh/id_ed25519_bc` (→ `github-bc`) | — |

- Work repos are identified by **path** (`~/code/commerce/`), not machine — clone
  work repos there and git uses the work email automatically.
- Clone work repos via the host alias: `git clone git@github-bc:org/repo.git`
  (or use the `gcw` alias: copy the `https://github.com/...` URL and run `gcw`).
- **Keys are one-per-machine and never copied** — that's why the two Macs have
  differently-named personal keys.

---

## Adding & removing apps (Homebrew)

nix-darwin drives Homebrew declaratively. Edit `darwin/hosts/work-laptop.nix`:

```nix
homebrew.casks = [ "raycast" "slack" /* … */ ];   # GUI apps + fonts
homebrew.brews = [ "corepack" "vale" /* … */ ];   # brew-only CLI (most CLI → Nix instead)
homebrew.taps  = [ "aprilnea/tap" ];              # third-party taps
```

Then `sudo darwin-rebuild switch …`.

> [!WARNING]
> `homebrew.onActivation.cleanup` is set to **`"none"`** (additive only) on
> purpose. `"uninstall"` mis-handles **tap casks** (it once removed
> `openlogi@latest`) and prompts mid-activation. To remove an app, delete it from
> the list **and** run `brew uninstall <app>` yourself.
>
> Casks from a custom tap must use the **full name**:
> `"aprilnea/tap/openlogi@latest"`, and the tap must be in `homebrew.taps`.

CLI tools generally go to **Nix** instead of brew — add them to `home.packages`
in `home/common.nix`.

---

## Common edits — where to change what

| I want to… | Edit | Then |
|---|---|---|
| Add a shell alias | `modules/zsh.nix` (`shellAliases`) | `switch` |
| Add a CLI tool | `home/common.nix` (`home.packages`) | `switch` |
| Add / remove an app | `darwin/hosts/work-laptop.nix` (`homebrew.casks`) | `switch` |
| Change the prompt | `starship/.config/starship.toml` | `switch` |
| Change terminal look | `ghostty/.config/ghostty/config` | `switch` |
| Change git identity | `modules/git.nix` (personal) / `home/hosts/work-laptop.nix` (work) | `switch` |
| Add an SSH host | `home/hosts/<host>.nix` (`programs.ssh.settings`) | `switch` |
| A macOS default (later) | `darwin/common.nix` (`system.defaults`) | `switch` |

---

## Troubleshooting

- **`sudo: darwin-rebuild: command not found`** — sudo strips PATH. Use the full
  path: `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake …`.
- **`does not provide attribute … darwinConfigurations.X`** — the flake key
  doesn't match the hostname. See [hostname changes](#machine-id-hostname-changes).
- **A CLI tool resolves to the brew copy, not Nix** — the zsh `initContent`
  re-asserts Nix ahead of Homebrew on PATH; open a fresh terminal.
- **`switch` wants to uninstall an app / prompts `[y/n]`** — that's `cleanup`.
  It's `"none"` here; if you ever set it to `"uninstall"`, expect this.
- **Roll back anything** — `sudo darwin-rebuild switch --rollback`.

---

## Remaining / roadmap

- Port macOS `defaults` into nix-darwin `system.defaults` (from the old `~/Setup`
  repo), then archive `~/Setup`.
- Give the personal machine its own `darwinConfigurations` entry and factor the
  shared cask list into `darwin/common.nix`.
