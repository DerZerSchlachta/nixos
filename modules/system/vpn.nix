{ config, pkgs, lib, ... }:

{
  # Ensure the VPN backend is available to NetworkManager
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  environment.systemPackages = with pkgs; [
    openvpn
    networkmanagerapplet
  ];

  # Optionally use this if you're managing secrets manually
  systemd.tmpfiles.rules = [
    # Set proper permissions for the VPN credentials file
    "f /etc/secure/openvpn/amsterdam.auth 0600 johannes users -"
  ];

  # Example: write the credentials securely at activation
  system.activationScripts.openvpnAuth = {
    text = ''
      install -Dm600 /home/johannes/.secrets/vpn-auth.txt /etc/secure/openvpn/amsterdam.auth
    '';
  };

  # Optional: a static OpenVPN service (you can also use nmcli)
  # services.openvpn.servers.amsterdam = {
  #   config = ''  # If you prefer to run OpenVPN directly rather than through NetworkManager
  #     config /etc/secure/openvpn/Amsterdam.conf
  #     auth-user-pass /etc/secure/openvpn/amsterdam.auth
  #   '';
  #   autoStart = true;
  # };

}
