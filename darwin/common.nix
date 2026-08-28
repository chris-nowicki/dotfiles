{ ... }:
{
  # Determinate Nix owns the Nix installation + daemon — nix-darwin must NOT
  # try to manage them, or it fights Determinate. This is required on this setup.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Required for user-scoped options (e.g. the homebrew module runs as this user).
  system.primaryUser = "chris.nowicki";

  # The user home-manager manages (the account already exists on the machine).
  users.users."chris.nowicki".home = "/Users/chris.nowicki";

  # nix-darwin state version (separate from home-manager's).
  system.stateVersion = 6;

  # Touch ID for sudo (manages /etc/pam.d/sudo_local, which already exists on
  # this machine — nix-darwin now owns it, keeping Touch ID sudo reproducible).
  security.pam.services.sudo_local.touchIdAuth = true;

  # Declarative Homebrew. nix-darwin drives an already-installed brew; it does
  # not install Homebrew itself.
  #
  # cleanup = "uninstall": enforce the manifest — remove any brew formula/cask
  # not declared here. This drops the brew copies of tools now provided by Nix
  # (eza, gh, lazygit, starship, stow, zoxide, zsh plugins). "uninstall" keeps
  # app data (unlike "zap").
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = false;
      upgrade = false;
    };
  };
}
