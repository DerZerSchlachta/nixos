{
  pkgs,
  inputs,
  nixFlakes,
  ...
}:
{
  programs.nh = {
      enable = true;
      flake = "/home/johannes/nixos";
    };

  environment.systemPackages = with pkgs; [
    nil # nix language server
    nixfmt  # nix file formatting

    #most important terminal-utilities:
    curl
    gnugrep
    unzip
    zip
    unrar
    mc
    dua
    dysk

    tldr # helpful commandline tool which explains a given command
    git # git repository managemnet
    wget # downloader

    fastfetch # command to display system info in Console
  ];
}