{ ... }:
{
  programs.git = {
    enable = true;

    # Default (personal) identity. Work identity is layered per-host via
    # includeIf in hosts/work-laptop.nix.
    settings = {
      user.name = "Chris Nowicki";
      user.email = "102450568+chris-nowicki@users.noreply.github.com";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential.helper = "osxkeychain";
      pull.rebase = true; # cleaner history than merge commits

      alias.whoami = "config user.email"; # check which email you're using
    };
  };
}
