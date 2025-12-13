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
      wakeOnLan.enable = true;
    };

    networkmanager.enable = true;

    firewall = {
      enable = true;

      allowedTCPPortRanges = [
        { from = 1714; to = 1764; }
      ];

      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];

      allowedUDPPorts = [ 1900 ];
      allowedTCPPorts = [ 49152 49153 49154 49155 49156 ];

      extraCommands = ''
        # SSDP multicast
        iptables -A INPUT  -d 239.255.255.250/32 -j ACCEPT
        iptables -A OUTPUT -d 239.255.255.250/32 -j ACCEPT

        # IGMP
        iptables -A INPUT -p igmp -j ACCEPT
        iptables -A OUTPUT -p igmp -j ACCEPT
      '';
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
