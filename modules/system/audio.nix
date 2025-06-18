{ pkgs, ... }:

{
  security.wrappers = {
    noisetorch = {
      # 'source' is required and must point to the real binary
      source = "${pkgs.noisetorch}/bin/noisetorch";
      # capabilities as a comma-separated string
      capabilities = "CAP_SYS_RESOURCE";
      owner = "root";  # or your username if appropriate
      group = "root";   # or another group the user belongs to
    };
  };

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      audio.enable = true;

      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };
  };
}
