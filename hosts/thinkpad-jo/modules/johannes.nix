{ config, pkgs, stablePkgs, ... }:

{
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    home = "/home/johannes";

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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKifFjJGI2ZnrUUxG9VTVzf7z4g9Fwg0t16FUIyCFCsP johannes@desktop"
    ];

    shell = pkgs.nushell;

    packages =
      (with pkgs; [
        # CLI
        freerdp

        discord
  
        freecad
        vscode.fhs

        firefox
      ])
      ++
      (with stablePkgs; [

        # Music:
        #streamrip
        #lmms
        feishin

        # Productivity
        
        #libreoffice

        # Creativity
        #inkscape
        gimp3

        thunderbird
        telegram-desktop
        signal-desktop

      ]);
  };

  users.defaultUserShell = pkgs.nushell;
}
