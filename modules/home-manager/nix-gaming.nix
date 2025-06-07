{ config, pkgs, lib, ... }:

let
  winePrefix = "${config.home.homeDirectory}/.wine-default";
in {
  home.packages = with pkgs; [
    lutris
    heroic
    bottles
    winetricks
    wineWowPackages.stagingFull
    protonup-qt
    vkBasalt
    dxvk
    vkd3d-proton
  ];

  home.sessionVariables = {
    WINEPREFIX = winePrefix;
    DXVK_HUD = "0"; # set to "1" if you want HUD enabled
  };

  # Optional: symbolic link for convenience
  home.file.".wine".source = winePrefix;
}
