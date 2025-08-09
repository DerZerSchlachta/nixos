{ pkgs, ... }:
{

  imports = [
    ./window-rules.nix
    ./workspace.nix
  ];

  programs.plasma = {
    enable = true;

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };
  };
}
