{ config, pkgs, lib, ... }:
{
  services.slskd = {
    enable = true;
    domain = "slskd.local";

    # 👇 add this
    environmentFile = "/var/lib/slskd/env";

    settings = {
      http = {
        address = "0.0.0.0";
        port = 5030;
      };

      downloads = {
        path = "/mnt/media/Downloads/slsk";
      };

      shares = {
        directories = [
          "/mnt/media/Music/johannes-music"
        ];
      };

    };
  };

  # ensure dirs exist
  systemd.tmpfiles.rules = [
    "d /mnt/media/Downloads/slsk 0755 root root -"
    "d /mnt/media/Music/johannes-music 0755 root root -"
    "d /var/lib/slskd 0700 root root -"
  ];
}
