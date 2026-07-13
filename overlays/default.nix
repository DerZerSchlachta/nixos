# overlays/default.nix
{ inputs }:

[
  inputs.deej.overlays.default

  (import ./handbrake.nix)
  (import ./freecad.nix)
]