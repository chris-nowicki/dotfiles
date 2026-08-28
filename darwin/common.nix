{ ... }:
{
  # Determinate Nix owns the Nix installation + daemon — nix-darwin must NOT
  # try to manage them, or it fights Determinate. This is required on this setup.
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Per-host: system.primaryUser + users.users.<name>.home (usernames differ).

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

    # Shared across both machines. Per-host extras live in darwin/hosts/*.nix.
    taps = [ "aprilnea/tap" ]; # openlogi
    brews = [
      "mole" # tw93 Mac cleaner
      "rulesync"
    ];
    casks = [
      "alt-tab"
      "capcut"
      "chatgpt"
      "claude-code"
      "cleanshot"
      "codex"
      "ghostty"
      "obs"
      "obsidian"
      "aprilnea/tap/openlogi@latest" # tap-qualified (short name gets mis-removed)
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
  };
}
