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
  # cleanup = "none": additive only, never auto-uninstall. The one-time removal
  # of the Nix-duplicated brew tools is already done; ongoing "uninstall" is too
  # risky here — it mis-handles tap-qualified casks (it wrongly removed
  # aprilnea/tap/openlogi@latest) and prompts interactively mid-activation.
  # Remove a cask manually with `brew uninstall` when needed.
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "none";
      autoUpdate = false;
      upgrade = false;
    };
  };
}
