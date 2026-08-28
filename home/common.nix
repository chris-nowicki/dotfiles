{ pkgs, ... }:
{
  imports = [
    ../modules/zsh.nix
    ../modules/git.nix
  ];

  # username is derived from the home-manager users key; homeDirectory is set
  # per-host (usernames differ across machines).

  # Never bump this casually — it pins state-migration behavior.
  home.stateVersion = "25.05";

  # CLI tools managed by Nix.
  # Still on Homebrew (formalized later via the homebrew module): mole
  # (tw93 Mac cleaner — nixpkgs `mole` is a different tool), rulesync
  # (not packaged), mas. Node is left to nvm.
  home.packages = with pkgs; [
    eza
    zoxide
    starship
    lazygit
    gh
    pnpm
    stow # keeps the stow-based rollback path independent of Homebrew
  ];

  # NOTE: streamdeck/restart-streamdeck.sh is a plain repo asset (not Nix-managed)
  # — the Stream Deck runs it directly at ~/Dotfiles/streamdeck/restart-streamdeck.sh.

  # Static configs kept verbatim (dumb symlinks, no rewrite). These become
  # read-only symlinks into /nix/store — edit the repo file + re-switch to change.
  xdg.configFile."starship.toml".source = ../starship/.config/starship.toml;
  xdg.configFile."ghostty/config".source = ../ghostty/.config/ghostty/config;

  programs.home-manager.enable = true;
}
