{ carapace }:

carapace.overrideAttrs (old: {
  postPatch = (old.postPatch or "") + ''
    rm completers/brew_completer/cmd/instal.go
    rm completers/brew_completer/cmd/uninstal.go
  '';
})
