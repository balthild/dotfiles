{ pkgs, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation {
  pname = "okular";
  version = "25.04";

  src = fetchurl {
    url = "https://cdn.kde.org/ci-builds/graphics/okular/release-25.04/macos-arm64/okular-release_25.04-6212-macos-clang-arm64.dmg";
    sha256 = "sha256-eaGO8pyIAZnuZMmvK/xtgmbqrypPVViOnjgGg64ozlw=";
  };
  sourceRoot = ".";

  nativeBuildInputs = [ pkgs.undmg ];
  buildInputs = [ ];

  dontConfigure = true;
  dontFixup = true;

  buildPhase = ''
    test -d okular.app

    /usr/bin/osacompile -o okular_droplet.app <<EOF
    on open droppedFiles
      repeat with f in droppedFiles
        set filePath to POSIX path of f
        do shell script "$out/Applications/okular.app/Contents/MacOS/okular " & quoted form of filePath & " >/dev/null 2>&1 &"
      end repeat
    end open
    EOF

    /usr/libexec/PlistBuddy \
      -c "Add :CFBundleIdentifier string 'com.apple.ScriptEditor.id.okular_droplet'" \
      -c "Delete :CFBundleDocumentTypes:0" \
      -c "Add :CFBundleDocumentTypes:0 dict" \
      -c "Add :CFBundleDocumentTypes:0:CFBundleTypeName string 'PDF'" \
      -c "Add :CFBundleDocumentTypes:0:CFBundleTypeRole string 'Viewer'" \
      -c "Add :CFBundleDocumentTypes:0:LSItemContentTypes array" \
      -c "Add :CFBundleDocumentTypes:0:LSItemContentTypes:0 string 'com.adobe.pdf'" \
      okular_droplet.app/Contents/Info.plist

    /usr/bin/codesign --force --sign - --timestamp=none okular_droplet.app
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r okular.app $out/Applications
    cp -r okular_droplet.app $out/Applications

    runHook postInstall
  '';
}
