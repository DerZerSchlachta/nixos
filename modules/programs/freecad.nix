{ pkgs, stablePkgs, ... }:
{
  environment.systemPackages = [
    stablePkgs.freecad
  ];
}