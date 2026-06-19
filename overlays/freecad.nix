# overlays/freecad.nix
final: prev: {
  freecad = prev.symlinkJoin {
    name = "freecad-pypresence";

    paths = [ prev.freecad ];

    buildInputs = [ prev.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/FreeCAD \
        --prefix PYTHONPATH : ${
          prev.python314Packages.makePythonPath [
            prev.python314Packages.pypresence
          ]
        }
    '';
  };
}