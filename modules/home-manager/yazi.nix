{ inputs, pkgs, ... }: let
in {
  programs.yazi = {
    # use flake to include pr enabling interaction with helix: https://github.com/sxyazi/yazi/pull/2461
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "yy";
    # settings = builtins.fromTOML (builtins.readFile ../../config/yazi/yazi.toml);
  };
}