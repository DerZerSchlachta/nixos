{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Ensure the VPN backend is available to NetworkManager
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  environment.systemPackages = with pkgs; [
    openvpn
    networkmanagerapplet
  ];
}
