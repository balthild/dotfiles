{ lib, pkgs, stdenv, fetchFromGitHub, fetchurl }:

stdenv.mkDerivation rec {
  pname = "realesrgan-ncnn-vulkan";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "xinntao";
    repo = "Real-ESRGAN-ncnn-vulkan";
    rev = "v${version}";
    sha256 = "sha256-OS/5t43NUS4/79fVIhoO7SS+iuiJn8P7OZVsYfi3Vvo=";
    fetchSubmodules = true;
    gitConfigFile = lib.toFile "gitconfig" ''
      [url "https://github.com/"]
        insteadOf = "git@github.com:"
    '';
  };

  models = fetchurl {
    url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-macos.zip";
    sha256 = "sha256-4K0FWAq/6yX42PtVqve+31UsN1tbTZvTyNWXZNLMMzo=";
  };

  nativeBuildInputs = [
    pkgs.unzip
    pkgs.cmake
    pkgs.glslang
    pkgs.makeBinaryWrapper
  ];

  buildInputs = [
    pkgs.vulkan-headers
    pkgs.vulkan-loader
  ];

  patches = [ ./macos-executable-path.patch ];

  cmakeDir = "../src";
  cmakeFlags = [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/libexec
    install -Dm755 realesrgan-ncnn-vulkan $out/libexec/realesrgan-ncnn-vulkan

    mkdir -p $out/libexec/models
    unzip -j ${models} 'models/*' -d $out/libexec/models

    mkdir -p $out/bin
    makeBinaryWrapper \
      $out/libexec/realesrgan-ncnn-vulkan \
      $out/bin/realesrgan-ncnn-vulkan

    runHook postInstall
  '';
}
