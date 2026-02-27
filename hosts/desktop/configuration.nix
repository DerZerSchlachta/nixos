{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  environment.sessionVariables = {
    NH_FLAKE = "/home/johannes/nixos";
  };

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    #import basics, which are the same for all machines
    ../../modules/core    

    #system:
      ./modules/nvidia.nix # gpu-driver config (nvidia)
      ./modules/johannes.nix  # user-specific-configuration

      ../../modules/system/audio.nix
      ../../modules/system/networking
      ../../modules/system/bluetooth.nix
      ../../modules/system/virtualisation.nix
      ../../modules/system/displayManager.nix
      
    #services:
      ../../modules/services/spicetify.nix  #spicetify spotify-client
      ../../modules/services/jellyfin
      ../../modules/services/printer.nix
      ../../modules/services/ollama.nix   #local LLM deployment

    #programs:
      ../../modules/programs/ausweisapp.nix
      ../../modules/programs/coolercontrol.nix
      ../../modules/programs/kde.nix

    #gaming:
    ../../modules/gaming
    ../../modules/gaming/sunshine.nix
  ];

  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;

    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "desktop-jo";
    interfaces.eno1.wakeOnLan.enable = true;
    enableIPv6 = false;
  };

services.samba = {
  enable = true;
  openFirewall = true;

  settings = {
    global = {
      workgroup = "WORKGROUP";
      security = "user";
      "map to guest" = "Bad User";
    };
  };

  shares = {
    media = {
      path = "/srv/media";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
    };
  };
};
  /*
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "eno1";
      WIFI_IFACE = "wlp7s0";
      SSID = "JoHotspot";
      PASSPHRASE = "1q2w3e4r";
    };
  };
  */
  services = {
    flatpak.enable = true; # installing (non-declarative) packages through flatpak / flathub
    udisks2.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "johannes";
    };
  };
  
  programs = {
    droidcam.enable = true;
  };

  # List packages installed in system profile:
  environment.systemPackages = with pkgs; [
    efibootmgr

    usbutils # needed for usb / serial management
    arduino-ide # Arduino IDE to create and deploy sketches as well as view the serial monitor
    #nixFlakes.packages.x86_64-linux.deej  #Small Programm to read and Apply Inputs from arduino-audio controllers, based on the "deej" system
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
