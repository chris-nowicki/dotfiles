{ ... }:
{
  # This machine's user.
  system.primaryUser = "wix";
  users.users."wix".home = "/Users/wix";

  # Personal-only apps (shared apps + fonts live in darwin/common.nix).
  homebrew.casks = [
    "claude"
    "discord"
    "fastmail"
    "google-chrome"
    "raycast"
    "slack"
    "spotify"
    "zoom"
  ];
}
