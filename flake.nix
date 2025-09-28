{
  description = "A flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    #nixpkgs_desktop.url = "github:nixos/nixpkgs/048597ae8f390af6aedd0ffd08878aaf32f9a210";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-flakes.url = "github:valenbar/nix-flakes";

    nix-flakes.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    refind-nix.url = "github:DerZerSchlachta/refind-nix"; # a nixos compatible version of rEFInd Bootmanager, aka. the nicest looking bootmanager

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-jellyfin-media-player.url = "github:nixos/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";

    #plasma-manager.url = "github:nix-community/plasma-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      nix-flakes,
      refind-nix,
      nix-gaming,
      nixos-hardware,
      ...
    }@inputs:
    let
      overlays = [
        (final: prev: {
          rimsort = prev.rimsort.overrideAttrs (old: {
            installPhase = old.installPhase + ''
              mkdir -p $out/share/applications
              cp ${builtins.head old.desktopItems}/share/applications/*.desktop $out/share/applications/
            '';
          });
        })
      ];
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
            nixFlakes = inputs.nix-flakes;
          };

          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.johannes = ./hosts/desktop/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.sharedModules = [
                plasma-manager.homeModules.plasma-manager
              ];
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
            nixFlakes = inputs.nix-flakes;
          };

          system = "x86_64-linux";
          modules = [

            ./hosts/thinkpad/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2 # for resolving hardware quirks, like missing wireless driver support

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.johannes = ./hosts/thinkpad/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.sharedModules = [
                plasma-manager.homeModules.plasma-manager
              ];
            }
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}
