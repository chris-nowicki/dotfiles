{ ... }:
{
  # This machine's user (corporate account).
  system.primaryUser = "chris.nowicki";
  users.users."chris.nowicki".home = "/Users/chris.nowicki";

  # Work-only brew CLI (shared mole/rulesync live in darwin/common.nix).
  homebrew.brews = [
    "corepack" # Node package-manager shim (works with nvm-managed node)
    "vale" # prose linter
  ];

  # Work-only apps (shared apps + fonts live in darwin/common.nix).
  homebrew.casks = [
    "bruno"
    "linear"
  ];
}
