{
  config,
  lib,
  pkgs,
  ...
}:
{
  #services.resolved.enable = true;#
  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    #hostId = "5388f8c5";
    hostName = "thinkpad";
    #usePredictableInterfaceNames = true;

    networkmanager = {
      enable = true;
      #wifi.backend ="iwd";
      #dns = "systemd-resolved";
    };

    #resolvconf.enable = true;


    #wireless.iwd.enable = true;

    firewall = {
      enable = true;

      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];

      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };

  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    AllowUsers = null;
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "yes";
    };
  };

  programs.ssh.startAgent = true;
}
