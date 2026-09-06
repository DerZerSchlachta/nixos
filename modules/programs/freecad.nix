{ pkgs, stablePkgs, ... }:
{
  environment.systemPackages = [
    pkgs.freecad
  ];
}