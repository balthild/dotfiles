{ ... }:

final: prev: {
  hyfetch-rs = prev.callPackage ./hyfetch-rs.nix { };
  carapace = prev.callPackage ./carapace.nix { carapace = prev.carapace; };
  okular = prev.callPackage ./okular.nix { };
}
