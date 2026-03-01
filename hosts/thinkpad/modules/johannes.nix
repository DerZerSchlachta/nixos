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
        libreoffice
        freecad

        # Creativity
        inkscape
        gimp3

        # Music
        feishin
        streamrip
        #lmms:
        lmms
        freepats

        firefox
      ])
      ++
      (with stablePkgs; [
        # Communication
        thunderbird
        
        telegram-desktop
        signal-desktop

        # Privacy-focused web browser
        librewolf
      ]);
  };

  users.defaultUserShell = pkgs.nushell;
}
