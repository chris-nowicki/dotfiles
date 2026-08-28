{
  description = "Chris Nowicki — Nix (nix-darwin + home-manager) config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { home-manager, nix-darwin, ... }:
    {
      # One integrated config: system + Homebrew + home-manager dotfiles.
      # Activate: `sudo darwin-rebuild switch --flake ~/Dotfiles#C7Q95C63WW`
      #
      # The personal machine will get its own darwinConfigurations entry that
      # imports ./home/hosts/personal.nix (unreferenced for now).
      darwinConfigurations."C7Q95C63WW" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/common.nix
          ./darwin/hosts/work-laptop.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true; # HM uses nix-darwin's pkgs
              useUserPackages = true; # home.packages → /etc/profiles/per-user
              backupFileExtension = "hm-bak"; # safety net for the standalone→module handoff
              users."chris.nowicki".imports = [
                ./home/common.nix
                ./home/hosts/work-laptop.nix
              ];
            };
          }
        ];
      };
    };
}
