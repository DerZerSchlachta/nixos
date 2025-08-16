{ ... }:
{
  programs.plasma.workspace = {

    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 25;
    };
    
<<<<<<< HEAD
    wallpaperSlideShow.path = "/home/johannes/Pictures/Wallpaper Paintings/";
=======
    wallpaperSlideShow.path = "/home/johannes/nixos/ressources/wallpapers";
>>>>>>> b8ebf87 (sddm background + plasma manager config)
    wallpaperFillMode = "preserveAspectCrop";
    wallpaperSlideShow.interval = 900; # 15 mins

    lookAndFeel = "org.kde.breezedark.desktop";
  };
}
