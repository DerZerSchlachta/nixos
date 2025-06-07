{
  description = "Gaming-ready NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flakes.url = "github:valenbar/nix-flakes";
    nix-flakes.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-flakes, nix-gaming, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-gaming.overlays.default ];
      };
    in {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          nixFlakes = inputs.nix-flakes;
        };

        system = system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.johannes = ./home.nix;
          }
        ];
      };
    };
}
