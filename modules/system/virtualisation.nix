# modules/virtualisation.nix
{ config, lib, pkgs, ... }:
let
  hostname  = config.networking.hostName or "";
  isDesktop = hostname == "desktop-jo";
  isLaptop  = hostname == "thinkpad-jo";
  isServer  = hostname == "server";
in
{
  #### Docker: enabled everywhere, behavior differs per host

  virtualisation.docker.enable = true;

  # On the ThinkPad (laptop): do NOT autostart Docker
  #systemd.services.docker.wantedBy = lib.mkIf isLaptop (lib.mkForce [ ]);

  # You can keep these generic
  systemd.services.docker.after = [ "network.target" ];
  systemd.services.docker.wants = [ "network.target" ];

  # On desktop/server, docker will use its default wantedBy from
  # virtualisation.docker.enable = true; (multi-user.target)
  # If you *explicitly* want to force it there as well, you could do:
  #
  # systemd.services.docker.wantedBy = lib.mkIf (isDesktop || isServer) [ "multi-user.target" ];


  #### VMware: host only where it makes sense

  # Maybe only on desktop:
  virtualisation.vmware.host.enable = lib.mkIf (!isServer) true;

  # Guest tools: maybe only on desktop + laptop, not server:
  virtualisation.vmware.guest.enable = lib.mkIf (!isServer) true;
}