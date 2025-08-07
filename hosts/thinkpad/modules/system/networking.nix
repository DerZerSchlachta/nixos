{ config, lib, pkgs, ... }:
{
  networking = {
    hostName = "thinkpad";
    usePredictableInterfaceNames = true;

    
    networkmanager.enable = true;

    firewall = {
      enable = true;

      allowedTCPPortRanges = [
        { from = 1714; to = 1764; }
      ];

      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];
    };
  };
}
