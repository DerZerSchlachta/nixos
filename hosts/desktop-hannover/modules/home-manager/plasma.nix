{ pkgs, ... }:
{

  imports = [
    ../../../../modules/home-manager/plasma/kwin.nix
    ../../../../modules/home-manager/plasma/window-rules.nix
    ../../../../modules/home-manager/plasma/workspace.nix
    ../../../../modules/home-manager/plasma/panels.nix
    ../../../../modules/home-manager/plasma/session.nix
    ./shortcuts.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = false;

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
