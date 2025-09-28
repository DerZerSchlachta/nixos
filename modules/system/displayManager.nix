# modules/system/displayManager.nix
{ config, pkgs, ... }:
let
  # Define the custom background package with the correct relative path
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ../../ressources/wallpapers/disco_elysium.png;  # Place wallpaper.jpg in the same directory as this config file
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
  };
in
{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
    autoNumlock = true;
  };


  environment.systemPackages = with pkgs; [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background = "${background-package}"
      '')
  ];

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";
}
