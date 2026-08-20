{config, ...}:
{
  fileSystems."/home/johannes/paperless-scans" = {
    device = "//fujitsu-d3431-a.local/paperless-scans/johannes";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.smb_server_pw.path}"  #path to a file with username= and password= properties, 
                                                              #generated and encrypted by agenix so only hosts with specific private ssh keys can access them
      "uid=1000"
      "gid=100"       
      "file_mode=0660"      #sets permissions for files to be read/write for owner and group, no access for others
      "dir_mode=0770"     #sets permissions for directories to be read/write/execute for owner and group, no access for others
      "x-systemd.automount"   #automounts the filesystem on first access, so it doesn't block boot if the server is not available
      "noauto"                
    ];
  };

  /*
  fileSystems."/mnt/Johannes" = {
    device = "192.168.178.202:/mnt/user/Johannes";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
      "x-systemd.after=network-online.target"
      "nofail"
    ];
  };
  */
  /*
  fileSystems."/mnt/media" = {
      device = "192.168.178.202:/mnt/user/Media";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "x-systemd.requires=network-online.target"
        "x-systemd.after=network-online.target"
        "nofail"
      ];
    };
    */
    /*
  fileSystems."/mnt/paperless-scans" = {
    device = "192.168.178.202:/mnt/user/paperless-scans";
    fsType = "smb";
    options = [
      "x-systemd.automount"
      "x-systemd.requires=network-online.target"
      "x-systemd.after=network-online.target"
      "nofail"
    ];
  };
  */
}