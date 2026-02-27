{...}:
{
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
        "map to guest" = "Bad User";
      };
    };

    shares = {
      media = {
        path = "/srv/media";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };
}