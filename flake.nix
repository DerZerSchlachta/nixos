{
  description = "My multi-host NixOS config";

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

    deej.url = "github:DerZerSchlachta/deej-linux";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      overlays = import ./overlays { inherit inputs; };

      mkHost = import ./lib/mkHost.nix {
        inherit inputs system overlays;
      };

      hosts = {
        desktop-jo = {
          user = "johannes";
        };
	
        desktop-hannover = {
          user = "johannes";
        };

        thinkpad-jo = {
          user = "johannes";
          extraModules = [
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
          ];
        };

        nixos-server = {
          user = "admin";
          extraHMModules = [ ];
        };
      };

    in {
      nixosConfigurations =
        nixpkgs.lib.mapAttrs
          (name: cfg: mkHost ({ hostname = name; } // cfg))
          hosts;
    };
}
