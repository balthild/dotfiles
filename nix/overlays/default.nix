final: prev: {
  carapace = prev.callPackage ./carapace.nix { carapace = prev.carapace; };
  mouse-accel = prev.callPackage ./mouse-accel { };
  h3image-ncnn-vulkan = prev.callPackage ./h3image-ncnn-vulkan.nix { };

  # https://lix.systems/add-to-config/#advanced-change
  inherit (prev.lixPackageSets.stable)
    nixpkgs-review
    nix-eval-jobs
    nix-fast-build
    colmena
    ;
}
