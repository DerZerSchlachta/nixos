{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
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
  };

  environment.systemPackages = with pkgs; [
    steam-run

    winetricks
    wineWow64Packages.waylandFull

    mangohud # displaying performance stats through an ingame-overlay

    lutris # game launcher, should be able to launch most windows games using wine
    heroic # epic games launcher for linux
  ];
}