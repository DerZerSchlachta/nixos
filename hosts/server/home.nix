{ inputs, ... }:
{
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ../../modules/home-manager/yazi.nix
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/nushell.nix
    ../../modules/home-manager/nix-search-tv.nix
  ];
}
