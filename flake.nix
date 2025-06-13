{
  description = "A flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flakes.url = "github:valenbar/nix-flakes";
    nix-flakes.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    refind-nix.url = "github:GrandtheUK/refind-nix"; #a nixos compatable version of rEFInd Bootmanager, aka. the nicest looking bootmanager
  };


  outputs = { self, nixpkgs, home-manager, nix-flakes, refind-nix, nix-gaming, ... }@inputs:
  {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {
    inherit inputs;
      nixFlakes = inputs.nix-flakes;
    };

      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.johannes = ./home.nix;
          home-manager.backupFileExtension = "backup";
        }

        # Add nix-gaming modules here (see step 3)
      ];
    };
  };
}
