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
          ip = "192.168.188.28";
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
    ];
  };
}