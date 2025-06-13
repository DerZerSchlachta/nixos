{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.refind-nix.nixosModules.refind
  ];

  boot.loader = {
    
    grub.enable = false;
    systemd-boot.enable = false;

    efi = {
      efiSysMountPoint = "/boot/EFI";
      canTouchEfiVariables = true;
    };
    refind = {
      enable = true;
      maxGenerations = 10;
      themes = [
   
        ];
    };
  };
}
