{ ccls, pkgs, fetchFromGitHub }:

# https://github.com/NixOS/nixpkgs/pull/451577
(ccls.override { llvmPackages_19 = pkgs.llvmPackages_21; }).overrideAttrs (old: rec {
  version = "0.20250815";

  src = fetchFromGitHub {
    owner = "MaskRay";
    repo = "ccls";
    rev = version;
    sha256 = "sha256-R+5pL0orUdHtquqvJa4esNmc6ETbX8WK5oJlBCSG+uI=";
  };

  cmakeFlags = [ "-DCCLS_VERSION=${version}" ];
})
