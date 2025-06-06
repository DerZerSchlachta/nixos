{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "desktop";
    usePredictableInterfaceNames = true;

    interfaces.eno1.macAddress = "02:00:00:00:00:01";

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
