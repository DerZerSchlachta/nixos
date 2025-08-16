{ ... }:
{
  programs.plasma.workspace = {

    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 25;
    };
    
    wallpaperSlideShow.path = "/home/johannes/nixos/ressources/wallpapers";
    wallpaperFillMode = "preserveAspectCrop";
    wallpaperSlideShow.interval = 900; # 15 mins

    lookAndFeel = "org.kde.breezedark.desktop";
  };
}
