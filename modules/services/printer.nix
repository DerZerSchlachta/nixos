{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix" # Proprietary Drivers Package, not included by default
  ];

  #scanning:

  hardware.sane = {
    enable = true; # enables support for SANE scanners
    extraBackends = [ pkgs.hplip ];
    brscan4 = {
      enable = true;
      netDevices = {
        DruckerZuHause = {
          model = "MFC-J470DW";
          ip = "192.168.178.28";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    simple-scan # GUI scanning tool
  ];

  #printing:
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
      pkgs.mfcj470dwlpr
      pkgs.mfcj470dw-cupswrapper
    ];
    # allow network access
    listenAddresses = [ "*:631" ];
    browsing = true;
    openFirewall = true;
    allowFrom = [ "all" ];
    defaultShared = true;
  };


  # discovery via mDNS/Avahi (lets other devices auto-find printers)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}