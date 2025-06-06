{ config, pkgs, ... }:

{
  users.users.johannes = {
    isNormalUser = true;
    description = "Johannes Bartschies";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.nushell;

    packages = with pkgs; [
      vscode.fhs
      thunderbird
      discord
      jellyfin-media-player
      neofetch
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZTXGgU26qfBpAfXsdTLwBaTmYfEvRbU6P9jBmTDk2/ administrator@WIN-OLCT0S163I8"
    ];
  };

  users.defaultUserShell = pkgs.nushell;
}
