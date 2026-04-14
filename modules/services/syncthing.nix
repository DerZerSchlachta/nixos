{ ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    settings = {
      devices = {
        laptop = { id = "ZHTG2H5-TN55DOV-VIJTLXP-J6OAJUQ-M6CXBUT-WQPANDR-B6HY6FU-GUETZQQ"; };
        server = { id = "IR4MBCI-VDGR7VV-LAD2EZG-QLNLBKD-SUWWDFJ-LL7RJL6-LADVWJP-T4O4BQD"; };
      };

      folders = {
        "personal-cloud" = {
          path = "/home/johannes/personal-cloud";
          devices = [ "laptop" "server" ];

          # Recommended for your setup
          ignorePerms = true;
        };
      };
    };
  };
}