{
  description = "A flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-jellyfin-media-player.url = "github:nixos/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";

    deej.url = "github:DerZerSchlachta/deej-linux";

    #plasma-manager.url = "github:nix-community/plasma-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      plasma-manager,
      nixos-hardware,
      deej,
      ...
    }@inputs:
    let
      overlays = [
        /*
        (final: prev: {
          rimsort = prev.rimsort.overrideAttrs (old: {
            installPhase = old.installPhase + ''
              mkdir -p $out/share/applications
              cp ${builtins.head old.desktopItems}/share/applications/*.desktop $out/share/applications/
            '';
          });
        })
        */

        (final: prev: {
          handbrake = prev.symlinkJoin {
            name = "handbrake-nvidia-wrapped";
            paths = [ prev.handbrake ];
            nativeBuildInputs = [ prev.makeWrapper ];
            postBuild = ''
              # Wrap CLI tool
              wrapProgram $out/bin/HandBrakeCLI \
                --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"

              # Wrap GUI tool
              wrapProgram $out/bin/ghb \
                --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
            '';
          };
        })

        inputs.deej.overlays.default

      ];
    in
    {
      nixosConfigurations = {
        desktop-jo = nixpkgs.lib.nixosSystem rec {
           specialArgs = {
            inherit inputs;

            stablePkgs = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = {
                inherit inputs;
              };

              home-manager.users.johannes = ./hosts/desktop/home.nix;

              home-manager.backupFileExtension = "backup";

              home-manager.sharedModules = [
                plasma-manager.homeModules.plasma-manager
                inputs.deej.home-managerModules.default
              ];
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        thinkpad-jo = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;

            stablePkgs = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
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
                inputs.deej.home-managerModules.default
              ];
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        server = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
          };

          system = "x86_64-linux";
          modules = [
            ./hosts/server/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.admin = ./hosts/server/home.nix;
              home-manager.backupFileExtension = "backup";
            }
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}