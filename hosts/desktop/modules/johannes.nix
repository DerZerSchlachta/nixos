{ config, pkgs, stablePkgs, ... }:

let
  orcaSlicerWrapped = pkgs.symlinkJoin {
    name = "orca-slicer";
    paths = [ pkgs.orca-slicer ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/orca-slicer \
        --set __GLX_VENDOR_LIBRARY_NAME mesa \
        --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json \
        --set MESA_LOADER_DRIVER_OVERRIDE zink \
        --set GALLIUM_DRIVER zink \
        --set WEBKIT_DISABLE_DMABUF_RENDERER 1
    '';
  };
in
{
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    extraGroups = [
      "root"
      "networkmanager"
      "wheel"
      "dialout"
      "docker"
      "realtime"
      "scanner"
      "lp"
    ];
    home = "/home/johannes";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/Tm8pI7kyVJg6bHE3Byop5ty9pRa0QnQqhQEUCdaKp johannes@thinkpad"
    ];

    shell = pkgs.nushell;

    packages =
      (with pkgs; [
        # Communication
        thunderbird
        discord
        telegram-desktop
        signal-desktop

        # CLI
        freerdp

        # Productivity
        vscode.fhs
        libreoffice

        # Creativity
        inkscape
        gimp3
        orcaSlicerWrapped
        freecad

        firefox

        feishin
        aonsoku
        streamrip
        mkvtoolnix
      ])
      ++
      (with stablePkgs; [
      ]);
  };

  users.defaultUserShell = pkgs.nushell;
}
