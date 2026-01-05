{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
}