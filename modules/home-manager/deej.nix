{ config, lib, pkgs, nixFlakes, ... }:

with lib;

let
  cfg = config.services.deej;

  # Use deej from your flake
  deejPkg = nixFlakes.packages.${pkgs.system}.deej;

  configFile = pkgs.writeText "deej-config.yaml" ''
    # process names are case-insensitive
    slider_mapping:
      0: master
      1:
        - firefox
        - zen
      2: deej.unmapped
      3: spotify
      4:
        - .Discord-wrapped
        - electron

    invert_sliders: false

    com_port: ${cfg.serialPort}
    baud_rate: ${toString cfg.baudRate}

    noise_reduction: ${toString cfg.noiseReduction}
  '';

in
{
  options.services.deej = {
    enable = mkEnableOption "deej volume control service";

    serialPort = mkOption {
      type = types.str;
      default = "/dev/ttyUSB0";
    };

    baudRate = mkOption {
      type = types.int;
      default = 9600;
    };

    noiseReduction = mkOption {
      type = types.float;
      default = 0.025;
    };

    verbose = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    # Install the binary
    home.packages = [ deejPkg ];

    # Create config file
    home.file.".config/deej/config.yaml".source = configFile;

    # Systemd user service
    systemd.user.services.deej = {
      Unit = {
        Description = "Deej volume control";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = ''
          ${deejPkg}/bin/deej-linux${optionalString cfg.verbose " -v"}
        '';

        Restart = "always";
        RestartSec = 5;
        WorkingDirectory = "%h/.config/deej";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };

    # Enable user services
    systemd.user.startServices = "sd-switch";
  };
}