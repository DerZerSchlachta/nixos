{inputs, ...}:
{
  home.username = "johannes";
  home.homeDirectory = "/home/johannes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ./modules/home-manager/yazi.nix
    ./modules/home-manager/btop.nix
    ./modules/home-manager/mpv.nix
    ./modules/home-manager/nushell.nix
    ./modules/home-manager/kdeconnect.nix
    
    #plasma-manager:
    ./modules/home-manager/plasma-manager/appearance.nix
    ./modules/home-manager/plasma-manager/plasma.nix
  ];
}
