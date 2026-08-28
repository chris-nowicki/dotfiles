{ ... }:
{
  # Brew-only CLI. The Nix-duplicated tools (eza, gh, lazygit, starship, stow,
  # zoxide, zsh-*) are intentionally omitted — home-manager owns those, and the
  # brew copies get cleaned up when cleanup flips to "uninstall".
  homebrew.brews = [
    "corepack" # Node package-manager shim (works with nvm-managed node)
    "mole" # tw93 Mac cleaner (nixpkgs `mole` is a different tool)
    "rulesync" # not packaged in nixpkgs
    "vale" # prose linter
  ];

  # GUI apps + fonts currently on this machine. When the personal machine is set
  # up, the shared subset moves to darwin/common.nix.
  homebrew.casks = [
    "alt-tab"
    "bruno"
    "capcut"
    "chatgpt"
    "claude-code"
    "cleanshot"
    "codex"
    "cursor"
    "ghostty"
    "linear"
    "obs"
    "obsidian"
    "openlogi@latest"
    "screen-studio"
    "visual-studio-code"
    "wispr-flow"

    # Fonts
    "font-anonymous-pro"
    "font-geist"
    "font-geist-mono"
    "font-inter"
    "font-meslo-lg-nerd-font"
    "font-reenie-beanie"
  ];

  # masApps: none enumerated (mas not signed in / no App Store apps here). Add as
  # `homebrew.masApps = { "Name" = <id>; };` if that changes.
}
