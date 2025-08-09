{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    extraConfig = "";
    settings = {
      vim_keys = true;
      shwon_boxes = "proc cpu mem net gpu0";
      proc_aggregate = true;
    };
    package = pkgs.btop.override {
      rocmSupport = true;
      cudaSupport = true;
    };
  };
}
