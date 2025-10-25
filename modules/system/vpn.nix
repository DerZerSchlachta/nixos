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
  /*
  services.openvpn.servers = {
    /*
    officeVPN = {
      config = ''config ../../../../openvpn/Amsterdam.conf '';
      updateResolvConf = true;
    };

    homeVPN = {
      config = ''config ../../../openvpn/Amsterdam.conf '';
      updateResolvConf = true;
    };
    serverVPN = {
      config = ''config ../../../../../openvpn/Amsterdam.conf '';
      updateResolvConf = true;
    };
    */

  };
  */
}
