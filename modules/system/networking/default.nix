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
  };
}