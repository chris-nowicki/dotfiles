{ pkgs, ... }:
{
  imports = [
    ../modules/zsh.nix
    ../modules/git.nix
  ];

  home.username = "chris.nowicki";
  home.homeDirectory = "/Users/chris.nowicki";

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

    # `restart-streamdeck` command (was streamdeck/restart-streamdeck.sh, a
    # never-stowed helper — now a reproducible command on PATH).
    (writeShellScriptBin "restart-streamdeck" ''
      osascript -e 'tell application "Stream Deck" to quit'
      sleep 3
      open "/Applications/Elgato Stream Deck.app"
    '')
  ];

  # Static configs kept verbatim (dumb symlinks, no rewrite). These become
  # read-only symlinks into /nix/store — edit the repo file + re-switch to change.
  xdg.configFile."starship.toml".source = ../starship/.config/starship.toml;
  xdg.configFile."ghostty/config".source = ../ghostty/.config/ghostty/config;

  programs.home-manager.enable = true;
}
