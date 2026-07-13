{ config, pkgs, stablePkgs, ... }:

let
  orcaSlicerWrapped = pkgs.symlinkJoin {
    name = "orca-slicer";
    paths = [ stablePkgs.orca-slicer ];
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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn/ac/j3TgmweX32o8GbGf7/5gG4gYdhtBnZcFUU6C2acVmzwfto+8a++qXUcXWcPXIA1UMbMfOrEI6ECWswOxQHpZayEWWc+YzXrXzlLgUnLTMUBUsggWmF62zibdlBvArzBsg4hjRX67WrQLvF6PrfJeiqpGxGsZdKQWYWtrZJHJlAwO55GK6PliAVoS9ZfZMiPxrOKm2MAx38syKo0hO5MPPxM2CMqH+50VMp60nKqx0OZEcpndtEOL6vTP2mpdUv5j4lwSRkmeE2WAgTqtW2+kSVrCqfDICE5X+5tKkvL7O5kdOgl4Uv2zFyUnjNYiYEtub9SCdCkGTKg2I0GZ Nothing Phone SSH Key"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0I6oH+o1AubOp3QrtwCTVvk20FbNctgkZjET5ThivS johannes@desktop-hannover"
    ];

    shell = pkgs.nushell;

    packages =
      (with pkgs; [
        libxcb-cursor
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
        #orca-slicer

        firefox

        feishin
        aonsoku
        streamrip
        mkvtoolnix
        makemkv
        vlc
      ])
      ++
      (with stablePkgs; [
      ]);
  };

  users.defaultUserShell = pkgs.nushell;
}
