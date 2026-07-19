{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  networking.firewall = {
    enable = true;

    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPorts = [ 
      1900
      53   # DNS
      67   # DHCP server
      68   # DHCP client
      59100 
      59200
      4444  #BeamMP
    ];

    allowedTCPPorts = [ 49152 49153 49154 49155 49156 59100 8000 4444 /*BeamMP*/];

    extraCommands = ''
      # SSDP multicast
      iptables -A INPUT  -d 239.255.255.250/32 -j ACCEPT
      iptables -A OUTPUT -d 239.255.255.250/32 -j ACCEPT

      # IGMP
      iptables -A INPUT -p igmp -j ACCEPT
      iptables -A OUTPUT -p igmp -j ACCEPT
    '';
  };
}