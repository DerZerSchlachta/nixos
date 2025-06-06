# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, nixFlakes, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = {
    FLAKE = "/home/johannes/nixos";
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/system/nvidia.nix
      ./modules/system/bluetooth.nix
      ./modules/system/networking.nix
      ./modules/system/users.nix
      ./modules/system/displayManager.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.tailscale.enable = true;

  services.openssh.enable = true; #enabling ssh-connections

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;



  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      mangohud
      gamemode
    ];
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
programs.gamemode.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
environment.systemPackages = with pkgs; [

  (sddm-astronaut.override {
    embeddedTheme = "astronaut";
  })

  freerdp

  inkscape  #Opensource SVG creator
  gimp3   #Opensource Photo editor
  tldr  #helpful commandline tool which explains a given command
  refind  #Bootmanager for a nicer dualboot experience
  efibootmgr  #Utility needed for Efi Bootmanagers (e.i. for rEFInd)
  librewolf #Privacy-focused FireFox Fork -> better Browser
  cool-retro-term #retro-looking console (not very practical)

  nil
  usbutils
  arduino-ide
  git
  wget

  mangohud  #displaying performance stats through an ingame-overlay
  heroic  #Epic games launcher for Linux
  
  nixFlakes.packages.x86_64-linux.deej
];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
  ];

  programs.nh = {
    enable = true;
    flake = "/home/johannes/nixos";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
