{
  pkgs,
  inputs,
  nixFlakes,
  stablePkgs,
  ...
}:
{
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam;

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

    #stablePkgs.lutris # game launcher, should be able to launch most windows games using wine
    heroic # epic games launcher for linux
  ];
}