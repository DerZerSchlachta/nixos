{ lib, config, pkgs, ... }:

let
  cfg = config.services.airvpn; #create a local variable to reduce code-repitition, purely for readability!
in
{
  # this section turns it into a module, using lib.mkOption, when can create variables a host importing the module has to set, pretty cool stuff honestly
  options.services.airvpn = {
    enable = lib.mkEnableOption "AirVPN WireGuard tunnel";

    address = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        WireGuard addresses assigned to this host by AirVPN.

        This must be set when services.airvpn.enable is true.
      '';
    };

    privateKeyFile = lib.mkOption {
      type = lib.types.path;
      default = config.age.secrets.airvpn-key.path;
      description = ''
        Path to the WireGuard private key.
        Defaults to the agenix airvpn-key secret.
      '';
    };

    presharedKeyFile = lib.mkOption {
      type = lib.types.path;
      default = config.age.secrets.airvpn-psk.path;
      description = ''
        Path to the WireGuard preshared key.
        Defaults to the agenix airvpn-psk secret.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # show a helpful error message if address aren't set!
    assertions = [
      {
        assertion = cfg.address != [ ];

        message = ''
          services.airvpn.enable is true, but services.airvpn.address is empty.

          Please configure the AirVPN WireGuard address for this host, for example:

            services.airvpn.address = [
              "10.x.x.x/32"
              "fd7d:.../128"
            ];
        '';
      }
    ];

    # create an exception for the tailscale ip-range, essentially stoping tailscale traffic from being routed through the vpn
    networking.wg-quick.interfaces.airvpn = {
      postUp = ''
        ${pkgs.iproute2}/bin/ip route replace \
          100.64.0.0/10 \
          dev tailscale0 \
          table 51820
      '';

      postDown = ''
        ${pkgs.iproute2}/bin/ip route del \
          100.64.0.0/10 \
          dev tailscale0 \
          table 51820 || true
      '';

      address = cfg.addresses;

      mtu = 1320;

      dns = [
        "10.128.0.1"
        "fd7d:76ee:e68f:a993::1"
      ];

      privateKeyFile = cfg.privateKeyFile;

      peers = [
        {
          publicKey =
            "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";

          presharedKeyFile = cfg.presharedKeyFile;

          endpoint = "nl3.vpn.airdns.org:1637";

          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];

          persistentKeepalive = 15;
        }
      ];
    };
  };
}