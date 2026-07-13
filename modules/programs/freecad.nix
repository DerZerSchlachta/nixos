{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.freecad
  ];
}