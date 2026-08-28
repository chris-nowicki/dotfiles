{
  description = "Chris Nowicki — home-manager config (work laptop + personal)";

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
    { nixpkgs, home-manager, nix-darwin, ... }:
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
      # home-manager (user/dotfiles) — activated with `home-manager switch`.
      # Will be folded into nix-darwin next; kept standalone during transition.
      homeConfigurations = {
        # This work laptop: carries BOTH personal (default) and work
        # (~/code/commerce/) identities.
        "work-laptop" = mkHome ./home/hosts/work-laptop.nix;

        # Personal machine: personal identity only.
        "personal" = mkHome ./home/hosts/personal.nix;
      };

      # nix-darwin (system + declarative Homebrew) — activated with
      # `sudo darwin-rebuild switch --flake .#C7Q95C63WW`.
      darwinConfigurations."C7Q95C63WW" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin/common.nix
          ./darwin/hosts/work-laptop.nix
        ];
      };
    };
}
