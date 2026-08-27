{ ... }:
{
  programs.git = {
    enable = true;

    # Default (personal) identity. Work identity is layered per-host via
    # includeIf in hosts/work-laptop.nix.
    userName = "Chris Nowicki";
    userEmail = "102450568+chris-nowicki@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "osxkeychain";
      pull.rebase = true; # cleaner history than merge commits
    };

    aliases = {
      whoami = "config user.email"; # check which email you're using
    };
  };
}
