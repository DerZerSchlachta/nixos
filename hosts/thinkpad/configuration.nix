# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.sessionVariables = {
    NH_FLAKE = "/home/johannes/nixos";
  };

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    #import basics, which are the same for all machines
    ../../modules/core    

    #system:
      ./modules/johannes.nix  # user-specific-configuration
      ./modules/power.nix

      ../../modules/system/audio.nix
      ../../modules/system/networking
      ../../modules/system/bluetooth.nix
      #../../modules/system/virtualisation.nix
      ./modules/display.nix
      
    #services:
      #../../modules/services/spicetify.nix  #spicetify spotify-client
      ../../modules/services/jellyfin
      ../../modules/services/printer.nix

    #programs:
      ../../modules/programs/ausweisapp.nix
      ../../modules/programs/kde.nix

    #gaming:
    ../../modules/gaming
  ];

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "thinkpad-jo";
  };

  #virtualisation.docker.enable = true;

  systemd.network.wait-online.enable = false; #could be problematic, but kinda delays boot a bit

  services = {
    flatpak.enable = true; # installing (non-declarative) packages through flatpak / flathub
    udisks2.enable = true;
  };


  programs = {
    droidcam.enable = true;
  };


  # List packages installed in system profile:
  environment.systemPackages = with pkgs; [
    moonlight-qt #game streaming client for sunshine
    #android-tools
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
