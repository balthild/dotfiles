cask "okular" do
  version "25.12-7067"
  sha256 "50dfeabb00c598b3ee5f4802162084e778010d080d159bfeb4e4a34a1f687d4c"

  url "https://cdn.kde.org/ci-builds/graphics/okular/release-25.12/macos-arm64/okular-release_25.12-7067-macos-clang-arm64.dmg"
  name "Okular"
  desc "The Universal Document Viewer"
  homepage "https://okular.kde.org/"

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "okular.app"

  postflight do
    system_command "/usr/bin/osacompile",
      args: [
        "-o", "#{appdir}/okular_droplet.app",
        "-e",
        <<~APPLESCRIPT
          on open droppedFiles
            repeat with f in droppedFiles
              set filePath to POSIX path of f
              set quotedPath to quoted form of filePath
              do shell script "#{appdir}/okular.app/Contents/MacOS/okular " & quotedPath & " >/dev/null 2>&1 &"
            end repeat
          end open
        APPLESCRIPT
      ]

    system_command "/usr/libexec/PlistBuddy",
      args: [
        "-c", "Add :CFBundleIdentifier string 'com.apple.ScriptEditor.id.okular_droplet'",
        "-c", "Delete :CFBundleDocumentTypes:0",
        "-c", "Add :CFBundleDocumentTypes:0 dict",
        "-c", "Add :CFBundleDocumentTypes:0:CFBundleTypeName string 'PDF'",
        "-c", "Add :CFBundleDocumentTypes:0:CFBundleTypeRole string 'Viewer'",
        "-c", "Add :CFBundleDocumentTypes:0:LSItemContentTypes array",
        "-c", "Add :CFBundleDocumentTypes:0:LSItemContentTypes:0 string 'com.adobe.pdf'",
        "#{appdir}/okular_droplet.app/Contents/Info.plist"
      ]

    system_command "/usr/bin/codesign",
      args: [
        "--force",
        "--sign",
        "-",
        "--timestamp=none",
        "#{appdir}/okular_droplet.app"
      ]
  end

  uninstall pkgutil: [
    "org.kde.okular",
    "com.apple.ScriptEditor.id.okular_droplet",
  ]

  zap trash: [
    "~/Library/Preferences/org.kde.okular.plist",
    "~/Library/Saved Application State/org.kde.okular.savedState",
  ]
end
