{pkgs, ...}:
{
  services.syncthing = {
    enable = true;
    #group = "mygroupname";
    user = "johannes";    
    dataDir = "/home/johannes/Documents";
    configDir = "/home/johannes/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    settings = {
      devices = {
        "FUJITSU-D3431-A" = { id = "IR4MBCI-VDGR7VV-LAD2EZG-QLNLBKD-SUWWDFJ-LL7RJL6-LADVWJP-T4O4BQD"; };
        #"desktop-jo" = { id = "DEVICE-ID-GOES-HERE"; };
      };
      folders = {
        "z2tid-uvgee" = {         # Name of folder in Syncthing, also the folder ID - "johannes"
          path = "/home/johannes/personal-cloud/";    # Which folder to add to Syncthing
          devices = [ "FUJITSU-D3431-A" ];      # Which devices to share the folder with
        };
      };
    };
  };
}