{ ... }:

final: prev: {
  hyfetch-rs = prev.callPackage ./hyfetch-rs.nix { };
}
