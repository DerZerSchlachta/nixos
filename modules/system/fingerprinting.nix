{ config, pkgs, lib, ... }:

{
  # keep fprintd running if you want it for other stuff
  services.fprintd.enable = true;

  # Custom PAM stack for SDDM that does NOT use fprint
  security.pam.services.sddm = {
    # Use the standard UNIX auth without fingerprint
    unixAuth = true;
    fprintAuth = false;
  };
}
