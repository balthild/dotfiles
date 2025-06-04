{ carapace }:

carapace.overrideAttrs (old: {
  postPatch = (old.postPatch or "") + ''
    rm completers/common/brew_completer/cmd/instal.go
    rm completers/common/brew_completer/cmd/uninstal.go
  '';
})
