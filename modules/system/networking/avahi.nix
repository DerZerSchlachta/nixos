{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}