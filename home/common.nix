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

  # CLI tools the interactive shell depends on (first migration slice).
  # More packages (pnpm, mole, rulesync, stow) land in a later slice.
  home.packages = with pkgs; [
    eza
    zoxide
    starship
    lazygit
    gh
  ];

  # Keep the hand-tuned starship prompt verbatim (dumb symlink, no rewrite).
  xdg.configFile."starship.toml".source = ../starship/.config/starship.toml;

  programs.home-manager.enable = true;
}
