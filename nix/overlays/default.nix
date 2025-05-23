{ ... }:

final: prev: {
  hyfetch-rs = prev.callPackage ./hyfetch-rs.nix { };
  carapace = prev.callPackage ./carapace.nix { inherit prev; };

  okular = prev.callPackage ./okular.nix { };
}
