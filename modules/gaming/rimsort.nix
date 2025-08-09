{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rimsort
  ];
}
