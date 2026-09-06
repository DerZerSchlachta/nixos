# overlays/rimsort.nix
final: prev: {
  python314Packages = prev.python314Packages.overrideScope (
    pyFinal: pyPrev: {
      steamworkspy = pyPrev.steamworkspy.overridePythonAttrs {
        dontCheckPythonMetadata = true;
      };
    }
  );
}