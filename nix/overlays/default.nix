{ ... }:

final: prev: {
  carapace = prev.callPackage ./carapace.nix { carapace = prev.carapace; };
  okular = prev.callPackage ./okular.nix { };
}
