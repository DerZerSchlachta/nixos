{ config, pkgs, ... }:

{
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    extraGroups = [
      "root"
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
      "realtime"
      "scanner"
      "lp"
    ];
    home = "/home/johannes";

    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKifFjJGI2ZnrUUxG9VTVzf7z4g9Fwg0t16FUIyCFCsP johannes@desktop"
    ];

    shell = pkgs.nushell;

    #All Programs / Tools for this User:
    packages = with pkgs; [
      #Communication:
      thunderbird
      discord
      telegram-desktop
      signal-desktop

      #Multimedia:
      jellyfin-media-player # Media Player for Jellyfin
      jellyfin-rpc

      #Command-line tools:
      fastfetch # command to display system info in Console
      cool-retro-term # retro-looking console (not very practical)
      tldr # helpful commandline tool which explains a given command
      git # git repository managemnet
      wget # downloader
      freerdp # Remote Desktop Client for the Console

      #Productivity:
      vscode.fhs # Visual Studio Code
      libreoffice
      nextcloud-client

      #Creativity:
      inkscape # Opensource SVG creator
      gimp3 # Opensource Photo editor

      #Gaming:
      mangohud # displaying performance stats through an ingame-overlay
    ];
  };

  users.defaultUserShell = pkgs.nushell;
}
