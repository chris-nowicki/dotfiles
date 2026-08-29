{ ... }:
{
  home.homeDirectory = "/Users/chris.nowicki";

  # Work identity, scoped to ~/code/commerce/ (where work repos live).
  programs.git.includes = [
    {
      condition = "gitdir:~/code/commerce/";
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

    # settings keyed by Host pattern, using upstream ssh_config directive names.
    settings = {
      "github.com" = {
        HostName = "github.com";
        IdentityFile = "~/.ssh/id_ed25519_personal";
        AddKeysToAgent = "yes";
        IdentitiesOnly = "yes";
        UseKeychain = "yes";
      };
      "github-bc" = {
        HostName = "github.com";
        IdentityFile = "~/.ssh/id_ed25519_bc";
        AddKeysToAgent = "yes";
        IdentitiesOnly = "yes";
        UseKeychain = "yes";
      };
    };
  };
}
