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
    ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.usePredictableInterfaceNames = true;

  networking.interfaces.eno1.macAddress = "02:00:00:00:00:01";



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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
  };
  services.desktopManager.plasma6.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    extraGroups = [ "networkmanager" "wheel" "dialout"];
    shell = pkgs.nushell;
    packages = with pkgs; [
      vscode.fhs
      thunderbird
      discord
      jellyfin-media-player
      neofetch
    ];

    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTXGgU26qfBpAfXsdTLwBaTmYfEvRbU6P9jBmTDk2/ administrator@WIN-OLCT0S163I8"
  ];
  };

  users.defaultUserShell = pkgs.nushell;

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

  networkmanager-openvpn     # Enables OpenVPN support in NetworkManager
  networkmanagerapplet     # GUI tray app for managing connections
  openvpn

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
  networking.firewall = {
    enable = true;
    # Ports for kdeconnect
    allowedTCPPortRanges = [
      { 
        from = 1714; 
        to = 1764; 
      }
    ];
    allowedUDPPortRanges = [
      { 
        from = 1714;
        to = 1764;
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
