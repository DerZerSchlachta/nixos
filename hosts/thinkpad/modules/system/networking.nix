{ config, lib, pkgs, ... }:
{
  #services.resolved.enable = true;
  networking = {
    #hostId = "5388f8c5";
    hostName = "thinkpad";
    #usePredictableInterfaceNames = true;

    networkmanager = {
      enable = true;
      #wifi.backend ="iwd";
      #dns = "systemd-resolved";
    };

    #wireless.iwd.enable = true;

    interfaces = {
      enp2s0f0.useDHCP = true;
      enp5s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };

    useDHCP = false;

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
