{ ... }:
{
programs.plasma.panels = [
    {
      floating = true;
      location = "bottom";
<<<<<<< HEAD
      opacity = "adaptive";
=======
      opacity = "translucent";
>>>>>>> b8ebf87 (sddm background + plasma manager config)
      height = 44;
      widgets = [ #taskbar widgets from left to right:
        "org.kde.plasma.pager"    # virtual desktops
        "org.kde.plasma.panelspacer"  # spacer
        {
          kickoff = {   #startmenu
            sortAlphabetically = true;
<<<<<<< HEAD
            icon = "/home/johannes/Pictures/Icons/self_made_icons/Desktop_icons/NixOS.png";
=======
            icon = "/home/johannes/nixos/ressources/icons/NixOS.png";
>>>>>>> b8ebf87 (sddm background + plasma manager config)
          };
        }
        {
          iconTasks = { # list of app-icons to display:
            appearance = {
              showTooltips = true;
              highlightWindows = true;
              indicateAudioStreams = true;
              fill = true;
            };
            launchers = [
              "applications:org.kde.konsole.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:librewolf.desktop"
              "applications:spotify.desktop"
              "applications:code.desktop"
              "applications:discord.desktop"
              "applications:steam.desktop"
            ];
          };
        }
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.marginsseparator"
        {
          systemTray.items = {
            shown = [
              "org.kde.plasma.battery"
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.networkmanagement"
            ];
          };
        }
        "org.kde.plasma.digitalclock"
      ];
    }
  ];
}
