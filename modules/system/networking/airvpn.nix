{ lib, config, pkgs, ... }:

let
  cfg = config.services.airvpn; # create a local variable to reduce code-repetition, purely for readability!
  unitName = "wg-quick-airvpn.service";
in
{
  # this section turns it into a module, using lib.mkOption, which can create variables a host importing the module has to set, pretty cool stuff honestly
  options.services.airvpn = {
    enable = lib.mkEnableOption "AirVPN WireGuard tunnel";

    address = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        WireGuard address assigned to this host by AirVPN.

        This must be set when services.airvpn.enable is true.
      '';
    };

    privateKeyFile = lib.mkOption {
      type = lib.types.path;
      default = config.age.secrets.airvpn-key.path;
      description = ''
        Path to the WireGuard private key.
        Defaults to the agenix airvpn-key secret.
      '';
    };

    presharedKeyFile = lib.mkOption {
      type = lib.types.path;
      default = config.age.secrets.airvpn-psk.path;
      description = ''
        Path to the WireGuard preshared key.
        Defaults to the agenix airvpn-psk secret.
      '';
    };

    allowUnprivilegedControl = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether members of the `wheel` group may start, stop, restart,
        enable, or disable the `${unitName}` systemd unit without a
        password prompt, via a Polkit rule.

        This is coarse-grained: Polkit's `manage-units` action does not
        distinguish start from stop, so enabling this lets any active
        wheel-group session silently stop the VPN as easily as start it.
        Leave this off on hosts where you want to be prompted (or where
        other users are also in `wheel`).
      '';
    };

    installPanelToggle = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Install a KDE Plasma panel widget (plasmoid) that shows the
        current state of `${unitName}` and lets you start/stop it with
        a click.

        Requires `services.airvpn.allowUnprivilegedControl = true` to
        actually be clickable without a password prompt each time.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # show a helpful error message if address aren't set!
    assertions = [
      {
        assertion = cfg.address != [ ];
        message = ''
          services.airvpn.enable is true, but services.airvpn.address is empty.

          Please configure the AirVPN WireGuard address for this host, for example:

            services.airvpn.address = [
              "10.x.x.x/32"
              "fd7d:.../128"
            ];
        '';
      }
    ];

    warnings = lib.optional
      (cfg.installPanelToggle && !cfg.allowUnprivilegedControl)
      ''
        services.airvpn.installPanelToggle is true, but
        services.airvpn.allowUnprivilegedControl is false. Clicking the
        panel toggle will trigger a Polkit password prompt every time
        instead of toggling instantly.
      '';

    # create an exception for the tailscale ip-range, essentially stopping tailscale traffic from being routed through the vpn
    networking.wg-quick.interfaces.airvpn = {
      autostart = false;
      postUp = ''
        ${pkgs.iproute2}/bin/ip route replace \
          100.64.0.0/10 \
          dev tailscale0 \
          table 51820
      '';

      postDown = ''
        ${pkgs.iproute2}/bin/ip route del \
          100.64.0.0/10 \
          dev tailscale0 \
          table 51820 || true
      '';

      address = cfg.address;

      mtu = 1320;

      dns = [
        "10.128.0.1"
        "fd7d:76ee:e68f:a993::1"
      ];

      privateKeyFile = cfg.privateKeyFile;

      peers = [
        {
          publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
          presharedKeyFile = cfg.presharedKeyFile;
          endpoint = "nl3.vpn.airdns.org:1637";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          persistentKeepalive = 15;
        }
      ];
    };

    security.polkit.extraConfig = lib.mkIf cfg.allowUnprivilegedControl ''
      polkit.addRule(function(action, subject) {
        if (
          subject.active &&
          subject.isInGroup("wheel") &&
          action.id == "org.freedesktop.systemd1.manage-units" &&
          action.lookup("unit") == "${unitName}"
        ) {
          return polkit.Result.YES;
        }
      });
    '';

    environment.variables.QML2_IMPORT_PATH = lib.mkIf cfg.installPanelToggle
      "${pkgs.kdePackages.plasma5support}/lib/qt-6/qml:$QML2_IMPORT_PATH";

    environment.systemPackages = lib.mkIf cfg.installPanelToggle [
      pkgs.kdePackages.plasma5support
      (
        let
          metadataJson = pkgs.writeText "airvpn-toggle-metadata.json" (builtins.toJSON {
            KPlugin = {
              Id = "org.you.airvpntoggle";
              Name = "AirVPN Toggle";
              Description = "Toggle the AirVPN WireGuard connection";
              Icon = "network-vpn";
              ServiceTypes = [ "Plasma/Applet" ];
              Version = "0.1.0";
            };
            "X-Plasma-API-Minimum-Version" = "6.0";
            "X-Plasma-MainScript" = "ui/main.qml";
          });
          mainQml = pkgs.writeText "airvpn-toggle-main.qml" ''
            import QtQuick
            import QtQuick.Layouts
            import QtQuick.Controls as Controls
            import org.kde.plasma.plasmoid
            import org.kde.plasma.core as PlasmaCore
            import org.kde.plasma.plasma5support as P5Support
            import org.kde.kirigami as Kirigami

            PlasmoidItem {
                id: root
                property bool vpnActive: false

                Plasmoid.icon: root.vpnActive ? "network-vpn" : "network-vpn-disabled"

                P5Support.DataSource {
                    id: statusSource
                    engine: "executable"
                    connectedSources: []
                    onNewData: (sourceName, data) => {
                        root.vpnActive = (data["stdout"].trim() === "active")
                        disconnectSource(sourceName)
                    }
                }

                Timer {
                    interval: 2000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: statusSource.connectSource(
                        "systemctl is-active wg-quick-airvpn.service"
                    )
                }

                P5Support.DataSource {
                    id: toggleSource
                    engine: "executable"
                    connectedSources: []
                    onNewData: (sourceName) => disconnectSource(sourceName)
                }

                function toggleVpn() {
                    var cmd = root.vpnActive
                        ? "systemctl stop wg-quick-airvpn.service"
                        : "systemctl start wg-quick-airvpn.service"
                    toggleSource.connectSource(cmd)
                }

                compactRepresentation: MouseArea {
                    Layout.minimumWidth: PlasmaCore.Units.iconSizes.small
                    Layout.minimumHeight: PlasmaCore.Units.iconSizes.small
                    onClicked: root.toggleVpn()

                    Kirigami.Icon {
                        anchors.fill: parent
                        source: root.vpnActive
                            ? Qt.resolvedUrl("../images/connected.svg")
                            : Qt.resolvedUrl("../images/disconnected.svg")
                    }
                }

                fullRepresentation: Item {
                    Layout.preferredWidth: PlasmaCore.Units.gridUnit * 12
                    Layout.preferredHeight: PlasmaCore.Units.gridUnit * 4

                    Column {
                        anchors.centerIn: parent
                        spacing: PlasmaCore.Units.smallSpacing

                        Text {
                            text: root.vpnActive ? "AirVPN: Connected" : "AirVPN: Disconnected"
                        }
                        Controls.Button {
                            text: root.vpnActive ? "Disconnect" : "Connect"
                            onClicked: root.toggleVpn()
                        }
                    }
                }
          }
          '';

          iconConnected = ./../../../ressources/icons/vpn-toggle/connected.svg;
          iconDisconnected = ./../../../ressources/icons/vpn-toggle/disconnected.svg;
        in
          pkgs.stdenvNoCC.mkDerivation {
            pname = "airvpn-toggle-plasmoid";
            version = "0.1.0";
            dontUnpack = true;
            installPhase = ''
              dest=$out/share/plasma/plasmoids/org.you.airvpntoggle
              mkdir -p $dest/contents/ui $dest/contents/images
              cp ${metadataJson} $dest/metadata.json
              cp ${mainQml} $dest/contents/ui/main.qml
              cp ${iconConnected} $dest/contents/images/connected.svg
              cp ${iconDisconnected} $dest/contents/images/disconnected.svg
            '';
          }
      )
    ];
  };
}