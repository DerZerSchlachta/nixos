{ pkgs, ... }:{
  programs.mpv = {
    enable = true;
    # extraInput = builtins.readFile 
    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
    ];
  };
}
