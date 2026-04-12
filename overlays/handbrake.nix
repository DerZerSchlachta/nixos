final: prev: {
  handbrake = prev.symlinkJoin {
    name = "handbrake-nvidia-wrapped";
    paths = [ prev.handbrake ];
    nativeBuildInputs = [ prev.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/HandBrakeCLI \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"

      wrapProgram $out/bin/ghb \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
    '';
  };
}