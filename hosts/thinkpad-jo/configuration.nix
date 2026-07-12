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
      ../../modules/system/virtualisation.nix
      ./modules/display.nix
      
    #services:
      #../../modules/services/spicetify.nix  #spicetify spotify-client
      #../../modules/services/jellyfin
      ../../modules/services/printer.nix
      ../../modules/services/syncthing.nix

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

  systemd.user.services.copyparty-sync = {
    description = "Sync Copyparty folder locally";
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone bisync personal-cloud: /home/johannes/personal-cloud";
    };
  };

  systemd.user.services.mediaserver-mount = {
    description = "Mount mediaserver via rclone";
    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount mediaserver: /home/johannes/mediaserver \
        --vfs-cache-mode writes \
        --buffer-size 64M \
        --dir-cache-time 1h";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;

    # 👇 THIS is the key line you're missing
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.conf.default.accept_ra" = 0;
  };

  hardware.amdgpu = {
    initrd.enable = true;
    overdrive.enable = true;
  };
  services.lact.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
