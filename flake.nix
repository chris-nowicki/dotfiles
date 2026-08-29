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
    let
      # One integrated config per machine: system + Homebrew + home-manager
      # dotfiles. Activate: `sudo darwin-rebuild switch --flake .#<hostname>`.
      mkDarwin =
        { user, darwinHost, homeHost }:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./darwin/common.nix
            darwinHost
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "hm-bak";
                users.${user}.imports = [
                  ./home/common.nix
                  homeHost
                ];
              };
            }
          ];
        };
    in
    {
      darwinConfigurations = {
        # Work laptop — carries both personal (default) and work identities.
        "C7Q95C63WW" = mkDarwin {
          user = "chris.nowicki";
          darwinHost = ./darwin/hosts/work-laptop.nix;
          homeHost = ./home/hosts/work-laptop.nix;
        };

        # Personal machine.
        "Wixys-MacBook-Pro" = mkDarwin {
          user = "wix";
          darwinHost = ./darwin/hosts/personal.nix;
          homeHost = ./home/hosts/personal.nix;
        };
      };
    };
}
