{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "mouse-accel";
  version = "0.1.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = ./mouse-accel.c;
  };

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild
    $CC -fblocks -O2 -Wall -Wextra -o mouse-accel mouse-accel.c \
      -framework IOKit -framework CoreFoundation
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 mouse-accel $out/bin/mouse-accel
    runHook postInstall
  '';

  meta = {
    description = "Restore Apple's pointer acceleration curve on Karabiner's virtual mouse";
    mainProgram = "mouse-accel";
    platforms = lib.platforms.darwin;
  };
}
