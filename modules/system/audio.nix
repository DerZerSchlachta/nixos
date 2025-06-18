{ pkgs, ... }:
{
  services = {
    pulseaudio.enable = false;
    #Pipewire Audiosystem, which is superior to pulseaudio!
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      audio.enable = true;

      lowLatency = {
        enable = true;
        # optional:
        quantum = 64;
        rate = 48000;
      };
    };
  }
}

