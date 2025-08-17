{ ... }:
{
  programs.plasma.window-rules = [
    {
      description = "Steam to Gaming desktop";

      # all windows gaming related windows to desktop: 2:Gaming
      match.window-class = {
        value = "steam|discord|heroic|lutris";
        type = "regex";
      };
      #move to "Gaming" Desktop
      apply = {
        desktops = "Desktop_2";
      };
    }
    {
      description = "VMware stuff gets its own Desktop";

      # all windows gaming related windows to desktop: 2:Gaming
      match.window-class = {
        value = "vmware";
        type = "substring";
      };

      apply = {
        desktops = "Desktop_3";
      };
    }
  ];
}
