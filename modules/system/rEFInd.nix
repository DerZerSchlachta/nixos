{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.refind-nix.nixosModules.refind
  ];

  boot.loader = {
    
    grub.enable = false;
    systemd-boot.enable = true;

    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
    refind = {
      enable = false;
      maxGenerations = 10;
      themes = [
   
        ];
    };
  };
}
