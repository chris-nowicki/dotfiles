{ ... }:
{
  # Work identity, scoped to ~/Dev/commerce/ (mirrors the old includeIf gitdir).
  programs.git.includes = [
    {
      condition = "gitdir:~/Dev/commerce/";
      contents.user.email = "chris.nowicki@bigcommerce.com";
    }
  ];

  # Work-only shell helpers (the personal machine never gets these).
  programs.zsh.shellAliases = {
    gcw = "echo \"Cloning work repo:\" && git clone $(pbpaste | sed \"s/github.com/github-bc/g\")";
    gcwm = "echo \"Mirroring work repo:\" && git clone --mirror $(pbpaste | sed \"s/github.com/github-bc/g\")";
  };

  # SSH: this machine's personal key is custom-named (_personal); the work
  # (_bc) key adds the github-bc host alias.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # don't emit a `Host *` block we never had
    includes = [ "conductor_config" ]; # preserve Conductor's Include line

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_personal";
        addKeysToAgent = "yes";
        identitiesOnly = true;
        extraOptions.UseKeychain = "yes";
      };
      "github-bc" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_bc";
        addKeysToAgent = "yes";
        identitiesOnly = true;
        extraOptions.UseKeychain = "yes";
      };
    };
  };
}
