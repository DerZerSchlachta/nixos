{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  programs.coolercontrol.enable = true; # fan control-software
  
  environment.systemPackages = with pkgs; [
    lm_sensors # tool for readin hardware sensors, needed by coolercontrol
  ];
}