{ ... }:
{
  # Personal machine: single default-named key, no work identity.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # don't emit a `Host *` block we never had
    settings."github.com" = {
      HostName = "github.com";
      IdentityFile = "~/.ssh/id_ed25519";
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
      UseKeychain = "yes";
    };
  };
}
