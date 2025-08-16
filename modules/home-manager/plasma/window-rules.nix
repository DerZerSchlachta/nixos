{ ... }:
{
  programs.plasma.window-rules = [
    {
      description = "Steam to Gaming desktop";

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
      };
    }
  ];
}
