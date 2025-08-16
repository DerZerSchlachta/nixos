{ pkgs, ... }:
{

  imports = [
    ../../../../modules/home-manager/plasma/kwin.nix
    ../../../../modules/home-manager/plasma/window-rules.nix
    ../../../../modules/home-manager/plasma/workspace.nix
    ../../../../modules/home-manager/plasma/panels.nix
    ../../../../modules/home-manager/plasma/session.nix
<<<<<<< HEAD
=======
    ../../../../modules/home-manager/plasma/shortcuts.nix
>>>>>>> b8ebf87 (sddm background + plasma manager config)
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
