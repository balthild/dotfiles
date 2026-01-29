{ stdenvNoCC, fetchurl, unzip }:

stdenvNoCC.mkDerivation rec {
  pname = "yarn-switch";
  version = "6.0.0-rc.13";

  src = fetchurl {
    url = "https://repo.yarnpkg.com/releases/${version}/aarch64-apple-darwin";
    sha256 = "sha256-Pr04Zt4RohxQ/uEZ17fV461SyZa9R85KKy+KeQ2zS88=";
    name = "yarn-switch-${version}.zip";
  };

  nativeBuildInputs = [ unzip ];
  sourceRoot = ".";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp yarn $out/bin/yarn
    chmod +x $out/bin/yarn
  '';
}
