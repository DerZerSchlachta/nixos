{ pkgs,... }:
{
  programs.plasma = {
    enable = true;


    imports = [
      "./window_rules.nix"
      "./workspace.nix"
    ];

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";

  };
}
