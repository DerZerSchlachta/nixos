{ pkgs,... }:
{
  programs.plasma = {
    enable = true;

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };
    workspace = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      wallpaper = "/home/johannes/Pictures/Wallpaper Paintings/Disco_Elysium.jpg";
    };
  };
}
