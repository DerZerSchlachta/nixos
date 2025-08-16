{ ... }:
{
  programs.plasma.workspace = {

    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 25;
    };
    
    wallpaperSlideShow.path = "/home/johannes/Pictures/Wallpaper Paintings/";
    wallpaperFillMode = "preserveAspectCrop";
    wallpaperSlideShow.interval = 900; # 15 mins

    lookAndFeel = "org.kde.breezedark.desktop";
  };
}
