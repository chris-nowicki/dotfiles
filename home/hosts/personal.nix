{ ... }:
{
  # Personal machine: single default-named key, no work identity.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # don't emit a `Host *` block we never had
    matchBlocks."github.com" = {
      hostname = "github.com";
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";
      identitiesOnly = true;
      extraOptions.UseKeychain = "yes";
    };
  };
}
