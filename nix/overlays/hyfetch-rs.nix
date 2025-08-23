{ pkgs, lib, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation {
  pname = "hyfetch-rs";
  version = "2.0.0-rc1";

  # https://pypi.org/project/HyFetch/2.0.1/#files
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/py3/H/HyFetch/HyFetch-2.0.1-py3-none-macosx_11_0_arm64.whl";
    sha256 = "sha256-EknhiT4spWsMOtu2YY4ni1BthxWdysi0AGf7xwpvzqE=";
  };

  nativeBuildInputs = [ pkgs.unzip pkgs.makeBinaryWrapper ];
  buildInputs = [ ];

  unpackPhase = ''
    unzip $src
  '';

  buildPhase = ''
    test -f hyfetch/rust/hyfetch
  '';

  installPhase = ''
    install -d $out/libexec
    install -d $out/bin
    install hyfetch/rust/hyfetch $out/libexec/hyfetch
    makeBinaryWrapper $out/libexec/hyfetch $out/bin/hyfetch \
      --prefix PATH : ${lib.makeBinPath [ pkgs.fastfetch ]}
  '';
}
