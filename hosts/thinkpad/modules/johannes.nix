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

      #Command-line tools:
      freerdp # Remote Desktop Client for the Console

      #Productivity:
      vscode.fhs # Visual Studio Code
      libreoffice

      #Creativity:
      inkscape # Opensource SVG creator
      gimp3 # Opensource Photo editor

      librewolf # Privacy-focused FireFox Fork -> better Browser

      feishin
      streamrip
    ];
  };

  users.defaultUserShell = pkgs.nushell;
}
