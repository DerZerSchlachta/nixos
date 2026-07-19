{pkgs, ...}:
{
  services.syncthing = {
    enable = true;
    group = "users";
    user = "johannes";    
    dataDir = "/home/johannes/Documents";
    configDir = "/home/johannes/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    systemService = true;
    openDefaultPorts = true;
    settings = {
      devices = {
        "FUJITSU-D3431-A" = { id = "IR4MBCI-VDGR7VV-LAD2EZG-QLNLBKD-SUWWDFJ-LL7RJL6-LADVWJP-T4O4BQD"; };
        "thinkpad-jo" = { id = "ODVSYCS-7YKGOWB-L2ZJBAD-ZUSXLZ7-MCPFZHL-HBW7PZT-G33POAX-5UTA4AW"; };
        "desktop-jo" = { id = "EGHVULC-WUNGSR3-FSHCGLE-VI7F2RO-YNRRZV3-FWVSHXZ-BGOCE6P-XQJJEQ7"; };
        "nothing-phone" = { id = "5MSIYRP-5FZXFO5-TGZEEGX-BOLIYVF-YH3IZWD-O2NUGMK-YPS2D2P-KO7P7AN"; };
        "desktop-hannover" = { id = "KPL2ARX-7PSY7CS-YUUCJC5-AO3SPWS-ZPGLFGG-H5ANDBX-A5DWDJR-2WXKGA7"; }; 
      };
      folders = {
        "z2tid-uvgee" = {         # Name of folder in Syncthing, also the folder ID - "johannes"
          name = "johannes";
          path = "/home/johannes/personal-cloud/";    # Which folder to add to Syncthing
          devices = [ "FUJITSU-D3431-A" "thinkpad-jo" "desktop-jo" "nothing-phone" "desktop-hannover" ];      # Which devices to share the folder with
        };
      };
    };
  };
}