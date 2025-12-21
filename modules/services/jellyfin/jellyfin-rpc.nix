{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  systemd.user.services.jellyfin-rpc = {
    description = "Jellyfin RPC";
    serviceConfig.ExecStart = "${pkgs.jellyfin-rpc}/bin/jellyfin-rpc";
    wantedBy = [ "default.target" ];
  };

  environment.systemPackages = with pkgs; [
    jellyfin-rpc
  ];
}