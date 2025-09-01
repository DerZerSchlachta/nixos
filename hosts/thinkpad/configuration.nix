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

    #Cachix for nix-gaming:
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  environment.sessionVariables = {
    FLAKE = "/home/johannes/nixos";
  };

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/system/bluetooth.nix
    ./modules/system/networking.nix
    ../../modules/system/vpn.nix
    ./modules/system/users.nix
    ../../modules/system/displayManager.nix
    ../../modules/system/audio.nix
    ../../modules/system/fingerprinting.nix
    #../../modules/system/rEFInd.nix
    #../../modules/system/virtualisation.nix
    ../../modules/gaming/rimsort.nix

    inputs.spicetify-nix.nixosModules.default
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations

    "${inputs.nixpkgs}/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix" # Proprietary Drivers Package, not included by default
  ];

  boot.loader.systemd-boot.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };


  services = {
    tailscale.enable = true; # tailscale support
    openssh.enable = true; # enabling ssh-connections

    flatpak.enable = true; # installing (non-declarative) packages through flatpak / flathub
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    udisks2.enable = true;

  };
  hardware.sane = {
    enable = true; # enables support for SANE scanners
    brscan4 = {
      enable = true;
      netDevices = {
        DruckerZuHause = {
          model = "MFC-J470DW";
          ip = "192.168.188.28";
        };
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;

  programs = {

    steam = {
      enable = true;
      extraPackages = with pkgs; [
        mangohud
        gamemode
      ];
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;

    nh = {
      enable = true;
      flake = "/home/johannes/nixos";
    };

    spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          rotatingCoverart
          pointer
        ];

        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
    droidcam.enable = true;

  };

  # List packages installed in system profile:
  environment.systemPackages = with pkgs; [

    #kde-plasma related:

    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland

    simple-scan # GUI scanning tool

    librewolf # Privacy-focused FireFox Fork -> better Browser, should be the system-standart for every user

    #(terminal)-utility
    steam-run
    curl
    gnugrep
    unzip
    zip
    unrar
    mc # don't know how to access that one just yet
    efibootmgr
    dua
    dysk

    bitwarden-desktop

    nixfmt-rfc-style
    nil # nix language server

    vlc
    calibre

    #libsForQt5.qtstyleplugin-kvantum  #kvantum theme engine

    lutris # game launcher, should be able to launch most windows games using wine
    bottles # another game launcher, if lutris doesn't work
    heroic # epic games launcher for linux

    noisetorch # noise reduction through a virtual microphone

    usbutils # needed for usb / serial management
    arduino-ide # Arduino IDE to create and deploy sketches as well as view the serial monitor
    #nixFlakes.packages.x86_64-linux.deej  #Small Programm to read and Apply Inputs from arduino-audio controllers, based on the "deej" system
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
