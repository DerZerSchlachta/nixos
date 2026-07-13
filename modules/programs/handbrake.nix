{
  pkgs, stablePkgs, ...
}:
{
  environment.systemPackages = with pkgs; [
    stablePkgs.handbrake
  ];
}