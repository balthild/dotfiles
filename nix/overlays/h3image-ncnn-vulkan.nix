{ pkgs, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "h3image-ncnn-vulkan";
  version = "20261118";

  src = fetchurl {
    url = "https://github.com/nihui/h3image-ncnn-vulkan/releases/download/${version}/h3image-ncnn-vulkan-${version}-macos.zip";
    sha256 = "sha256-wcHzZfjHGfZpwpu/b7lDgIGJhDjPvNZowuJd8Lnkays=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  dontBuild = true;

  installPhase = ''
    install -Dm755 h3image-ncnn-vulkan $out/bin/h3image-ncnn-vulkan
  '';
}
