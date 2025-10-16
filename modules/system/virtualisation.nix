{ ... }:
{
  #Docker:
  virtualisation.docker.enable = true;
  # VM-Ware
  virtualisation.vmware.host.enable = true;
  # "nix-store --add-fixed sha256 VMware-Workstation-Full-17.6.4-24832109.x86_64.bundle" will add the downloaded package to the nix store!
  virtualisation.vmware.guest.enable = true;
}
