{ inputs, pkgs, ... }:
let
  system = pkgs.system;
  pkgs-jellyfin = import inputs.nixpkgs-jellyfin-media-player { inherit system; };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      jellyfin-media-player = pkgs-jellyfin.jellyfin-media-player;
    })
  ];

  environment.systemPackages = [ pkgs.jellyfin-media-player ];
}