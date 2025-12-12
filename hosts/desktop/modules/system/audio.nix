{ pkgs, config, ... }:

{
  services = {
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };

      extraConfig.pipewire."99-input-denoising" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "Noise Canceling source";
              "media.name" = "Noise Canceling source";
              "filter.graph" = {
                nodes = [
                  {
                    type = "ladspa";
                    name = "rnnoise";
                    plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                    label = "noise_suppressor_mono";
                    control = {
                      "VAD Threshold (%)" = 50.0;
                      "VAD Grace Period (ms)" = 200;
                      "Retroactive VAD Grace (ms)" = 0;
                    };
                  }
                ];
              };
              "capture.props" = {
                "node.name" = "effect_input.rnnoise";
                "node.passive" = true;
                "audio.rate" = 48000;
                "target.object" = "alsa_input.pci-0000_0c_00.4.analog-stereo";
              };
              "playback.props" = {
                "node.name" = "effect_output.rnnoise";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
              };
            };
          }
        ];
      };
    };
  };

  services.mpd = {
    enable = true;
    user = "johannes";
    musicDirectory = "/home/johannes/Music/";

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "alsa_output.pci-0000_0c_00.4.analog-stereo"
      }
    '';

    network.listenAddress = "any";
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.johannes.uid}";
  };
}
