{ pkgs, ... }:
{

  imports = [
    ./plasma/kwin.nix
    ./plasma/window-rules.nix
    ./plasma/workspace.nix
    ./plasma/panels.nix
    ./plasma/session.nix
    ./shortcuts.nix
    #./plasma/power.nix
    ./plasma/input.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    hotkeys.commands."launch-kwrite" = {
      name = "Launch KWrite";
      key = "Meta+Alt+W";
      command = "kwrite";
    };

    hotkeys.commands."launch-Nix-Config" = {
      name = "Launch Nix Config";
      key = "Meta+Alt+N";
      command = "code /home/johannes/nixos/";
    };
  };
}
