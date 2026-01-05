{ ... }:

final: prev: {
  carapace = prev.callPackage ./carapace.nix { carapace = prev.carapace; };
  ccls = prev.callPackage ./ccls.nix { ccls = prev.ccls; };
}
