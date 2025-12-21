{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };
}