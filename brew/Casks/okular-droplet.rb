cask "okular-droplet" do
  name "Okular Droplet"
  desc "Open files with Okular"
  homepage "https://okular.kde.org/"

  version "1.0.0"
  url "https://httpbin.org/status/200"

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64
  depends_on cask: "okular"

  app "okular_droplet.app"

  preflight do
    staged_path.mkpath

    system_command "/usr/bin/osacompile",
      args: [
        "-o", "#{staged_path}/okular_droplet.app",
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
        "#{staged_path}/okular_droplet.app/Contents/Info.plist"
      ]

    system_command "/usr/bin/codesign",
      args: [
        "--force",
        "--sign",
        "-",
        "--timestamp=none",
        "#{staged_path}/okular_droplet.app"
      ]
  end
end
