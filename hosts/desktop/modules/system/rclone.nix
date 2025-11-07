{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.rclone-ui ];
}