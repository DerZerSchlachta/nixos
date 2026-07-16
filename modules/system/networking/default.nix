{lib,...}:
{
  imports = [
    ./avahi.nix
    ./ssh.nix
    ./tailscale.nix
    ./firewall.nix
    ./vpn.nix
  ];

  networking = {
    hostName = lib.mkDefault "nixos";
    usePredictableInterfaceNames = true;
    networkmanager.enable = true;
    resolvconf.enable = false;
    nameservers = [ ];
    enableIPv6 = true;
  };

    networking.nat = {
    enable = true;
    externalInterface = "eno1";
    internalInterfaces = [ "wlp7s0" ];
  };
    services.resolved.enable = true;

}