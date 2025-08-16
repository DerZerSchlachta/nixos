{ ... }:
{
  programs.plasma.window-rules = [
    {
      description = "Steam to Gaming desktop";

<<<<<<< HEAD
      # all windows containing "steam" in title:
      match = {
        title = {
          value = "steam";
          type = "substring";
        };
      };
      #move to "Gaming" Desktop, forcefully!
      apply = {
        desktops = {
          value = "Gaming";
          apply = "force";
        };
=======
      # all windows gaming related windows to desktop: 2:Gaming
      match.window-class = {
        value = "steam|discord|heroic|lutris";
        type = "regex";
      };
      #move to "Gaming" Desktop, forcefully!
      apply = {
        desktops = "Desktop_2";
        #desktopsrule = "3";
>>>>>>> b8ebf87 (sddm background + plasma manager config)
      };
    }
  ];
}
