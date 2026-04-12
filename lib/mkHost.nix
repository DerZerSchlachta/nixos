{ inputs, system, overlays }:

{ hostname
, user
, extraModules ? [ ]
, extraHMModules ? [ ]
}:

let
  lib = inputs.nixpkgs.lib;

  pkgsStable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in

inputs.nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs;
    stablePkgs = pkgsStable;
  };

  modules =
  [
    ./../hosts/${hostname}/configuration.nix

    inputs.home-manager.nixosModules.home-manager

    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";

      home-manager.users.${user} =
        ./../hosts/${hostname}/home.nix;

      home-manager.sharedModules =
        [
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.deej.home-managerModules.default
        ] ++ extraHMModules;
    }

    { nixpkgs.overlays = overlays; }
  ]
  ++ extraModules;
}