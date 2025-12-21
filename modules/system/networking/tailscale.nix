{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  services.tailscale.enable = true; # tailscale support
}