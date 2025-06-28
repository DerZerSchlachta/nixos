{ config, pkgs, ... }:

let
  rimsort = pkgs.fetchFromGitHub {
    owner = "vinnymeller";
    repo = "nixpkgs";
    rev = "init-rimsort";
    sha256 = "sha256-Ke9H6BDrRfTcM0SWatr7XBf0bVYXsNTPnTvpQL8WH80=";
  };
in
{
  environment.systemPackages = with pkgs; [
    rimsort
  ];
}