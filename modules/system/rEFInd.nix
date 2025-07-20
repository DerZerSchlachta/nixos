{ config, lib, pkgs, inputs, ... }:

{
  boot.loader = {
    
    grub.enable = false;
    systemd-boot.enable = true;

    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
  };
}
