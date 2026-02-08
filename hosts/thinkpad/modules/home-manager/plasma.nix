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
  };
}
