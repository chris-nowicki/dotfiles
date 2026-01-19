# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using GNU Stow for symlink management. Each top-level directory represents a stow package that gets symlinked to the home directory (`~/`). The repository configures: zsh, ghostty, wezterm, git, karabiner, warp, and cspell.

## Key Commands

### Installation
```bash
# Install all dotfiles (must be run from ~/Dotfiles directory)
./install.sh

# Install a specific package
stow [package-name]

# Uninstall a package
stow -D [package-name]

# Re-stow (useful after modifying files)
stow -R [package-name]
```

### Prerequisites
GNU Stow must be installed: `brew install stow`

## Architecture and Patterns

### Stow Package Structure
Each directory (except `.git`, `.claude`) is a stow package that mirrors the home directory structure:
```
[package-name]/
└── [target-path-relative-to-home]/
    └── config-files
```

Example: `ghostty/.config/ghostty/config` symlinks to `~/.config/ghostty/config`

### Git Multi-Account Configuration
The git package uses conditional includes for automatic email switching:
- Default config (`.gitconfig`) uses GitHub noreply email
- Work config (`.gitconfig-bc`) is conditionally loaded for `~/Dev/commerce/` directory
- Pattern: `includeIf "gitdir:~/Dev/commerce/"` in git/.gitconfig:19-20

When adding new git accounts, follow this pattern by creating additional `.gitconfig-[suffix]` files with corresponding `includeIf` sections.

### Terminal Configurations
Three terminal emulators are configured (ghostty, wezterm, warp):
- All use **Catppuccin Mocha** theme
- All use **MesloLGS Nerd Font Mono** (size 18-19)
- Ghostty and WezTerm share identical visual settings (opacity 0.8, blur 10)
- Only one terminal's config is active at a time (user preference)

### Zsh Enhancement Stack
The zsh/.zshrc:1-154 contains:
- **Prompt**: Powerlevel10k with custom p10k.zsh configuration
- **Navigation**: Zoxide (replaces `cd` with `z`)
- **Plugins**: zsh-autosuggestions, zsh-syntax-highlighting, thefuck
- **Node management**: NVM with lazy loading enabled
- **Aliases**: Development shortcuts for npm, pnpm, git, lazygit

### Karabiner Keyboard Remapping
The karabiner package remaps Caps Lock to a Hyper Key (Ctrl+Shift+Cmd+Option):
- Pressing alone still sends Caps Lock (preserves toggle functionality)
- Holding creates modifier combination for custom shortcuts
- Complex modifications stored in both `karabiner.json` and `assets/complex_modifications/`

## Important Files

### Installation Script (install.sh:1-41)
- Validates GNU Stow is installed
- Iterates through all directories, skipping empty ones
- Uses `set -e` to exit on any error
- Creates `.hushlogin` file to suppress login banners

### Gitignore (.gitignore)
Prevents tracking of:
- macOS system files (`.DS_Store`)
- Karabiner automatic backups
- IDE configuration (`.cursor/`, `.idea/`, `.vscode/`)
- Editor artifacts (`*.swp`, `*.swo`)

### CSpell Configuration (cspell/.config/cspell/cspell.json:1-34)
- Only checks non-code files (markdown, yaml, toml, git-commit, plaintext)
- Code files (JS, TS, JSX, TSX, etc.) explicitly disabled
- Custom dictionary includes: lucide, shadcn, zustand, tailwindcss, Raycast
- Ignores: hashes, SHAs, CONSTANT_CASE environment variables

## Development Workflow

When modifying configs:
1. Edit files directly in the stow package directory (e.g., `ghostty/.config/ghostty/config`)
2. Changes are immediately reflected via symlinks (no re-stow needed)
3. Commit changes to version control
4. Only re-stow (`stow -R [package]`) if you modify directory structure

When adding a new configuration:
1. Create a new directory with the application name
2. Mirror the home directory structure inside it
3. Place config files in the appropriate nested path
4. Run `./install.sh` or `stow [new-package-name]`
5. Update `.gitignore` if the application generates backup files

## Notes

- Repository location: `~/Dotfiles` (installation scripts assume this path)
- User prerequisite: Follow mac-setup guide at github.com/chris-nowicki/mac-setup before installation
- Symlinks mean editing files in either location (home or Dotfiles) affects both
- The install script skips empty directories automatically
