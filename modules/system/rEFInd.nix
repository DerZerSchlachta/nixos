{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.refind-nix.nixosModules.default
  ];

  boot.loader.refind-nix = {
    enable = true;
    theme = "minimal"; # Or other themes like "regular", "black", etc.
    extraConfig = ''
      timeout 10
      scanfor manual,external,hdbios
      showtools shell,memtest,gdisk,about,exit,reboot,shutdown
    '';
  };
}
