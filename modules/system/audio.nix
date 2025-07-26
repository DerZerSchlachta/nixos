{ pkgs, ... }:
{
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

  programs.noisetorch.enable = true;  #adding noisetorch to system config this way includes the needed security-wrapper which provided the special access / rights the program needs
}
