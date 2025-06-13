{ config, pkgs, ... }:

{
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
    home = "/home/johannes";

    shell = pkgs.nushell;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTXGgU26qfBpAfXsdTLwBaTmYfEvRbU6P9jBmTDk2/ administrator@WIN-OLCT0S163I8"
    ];
    
    #All Programs / Tools for this User:
    packages = with pkgs; [ 
      #Communication:
      thunderbird
      discord 

      #Multimedia:
      jellyfin-media-player #Media Player for Jellyfin
      #spotify-tui
      spotifyd

      #Command-line tools:
      neofetch  #command to display system info in Console
      cool-retro-term #retro-looking console (not very practical)
      tldr  #helpful commandline tool which explains a given command
      git #git repository managemnet
      wget  #downloader
      freerdp #Remote Desktop Client for the Console

      #Productivity:
      vscode.fhs  #Visual Studio Code
      libreoffice
      nextcloud-client

      #Nextcloud-Calendar Integration:
      kdePackages.korganizer
      kdePackages.akonadi
      kdePackages.kdepim-addons

      #Creativity:
      inkscape  #Opensource SVG creator
      gimp3   #Opensource Photo editor

      #Gaming:
      mangohud  #displaying performance stats through an ingame-overlay
    ];
  };

  users.defaultUserShell = pkgs.nushell;
}
