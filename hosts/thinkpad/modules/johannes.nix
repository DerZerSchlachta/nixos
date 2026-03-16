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
        
        # Productivity
        vscode.fhs

        # Creativity
        inkscape
        gimp3

        # Music
        feishin
        streamrip
        #lmms:
        lmms

        firefox
      ])
      ++
      (with stablePkgs; [
        # Communication
        thunderbird

        libreoffice
        freecad
        
        telegram-desktop
        signal-desktop
      ]);
  };

  users.defaultUserShell = pkgs.nushell;
}
