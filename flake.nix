{
  description = "Chris Nowicki — home-manager config (work laptop + personal)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      # Both Macs are Apple Silicon. Change here if a machine is Intel.
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome =
        hostModule:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/common.nix
            hostModule
          ];
        };
    in
    {
      homeConfigurations = {
        # This work laptop: carries BOTH personal (default) and work
        # (~/Dev/commerce/) identities.
        "work-laptop" = mkHome ./home/hosts/work-laptop.nix;

        # Personal machine: personal identity only.
        "personal" = mkHome ./home/hosts/personal.nix;
      };
    };
}
