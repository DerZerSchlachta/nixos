{
  description = "A flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-flakes.url = "github:valenbar/nix-flakes";
    nix-flakes.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    refind-nix.url = "github:DerZerSchlachta/refind-nix"; #a nixos compatable version of rEFInd Bootmanager, aka. the nicest looking bootmanager

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };


  outputs = { self, nixpkgs, home-manager, plasma-manager, nix-flakes, refind-nix, nix-gaming,... }@inputs:
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
          home-manager.sharedModules = [ 
            plasma-manager.homeManagerModules.plasma-manager 
          ];
        }
      ];
    };
  };
}
