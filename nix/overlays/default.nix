{ ... }:

final: prev: {
  carapace = prev.callPackage ./carapace.nix { carapace = prev.carapace; };
  ccls = prev.callPackage ./ccls.nix { ccls = prev.ccls; };
  yarn-switch = prev.callPackage ./yarn-switch.nix { };

  real-esrgan-ncnn-vulkan = prev.callPackage ./realesrgan-ncnn-vulkan { };

  # https://lix.systems/add-to-config/#advanced-change
  inherit (prev.lixPackageSets.stable)
    nixpkgs-review
    nix-eval-jobs
    nix-fast-build
    colmena
    ;
}
