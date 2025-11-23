{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking = {
    hostName = "desktop";
    usePredictableInterfaceNames = true;

    interfaces.eno1 = {
      macAddress = "02:00:00:00:00:01";
      wakeOnLan.enable = true;
    };

    networkmanager.enable = true;

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

      allowedUDPPorts = [ 9 ];
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
