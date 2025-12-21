{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user="johannes";
  };
}