cask "m9a" do
  name "M9A"
  desc "Assistant For Reverse: 1999"
  homepage "https://github.com/MAA1999/M9A"

  version "1.0.0"
  url "https://httpbin.org/status/200"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"
  depends_on formula: "m9a"

  app "M9A.app"

  preflight do
    system_command "curl",
      args: [
        "--silent",
        "-o", "#{staged_path}/M9A.png",
        "https://raw.githubusercontent.com/MAA1999/M9A/refs/heads/main/assets/logo.png",
      ]

    FileUtils.mkdir_p "#{staged_path}/M9A.iconset"
    for size in [16, 32, 64, 128, 256, 512]
      system_command "sips",
        args: [
          "-z", size.to_s, size.to_s,
          "--out", "#{staged_path}/M9A.iconset/icon_#{size}x#{size}.png",
          "#{staged_path}/M9A.png",
        ]
    end
    for size in [32, 64, 128, 256, 512]
      system_command "sips",
        args: [
          "-z", size.to_s, size.to_s,
          "--out", "#{staged_path}/M9A.iconset/icon_#{size/2}x#{size/2}@2x.png",
          "#{staged_path}/M9A.png",
        ]
    end

    FileUtils.mkdir_p "#{staged_path}/M9A.app/Contents/MacOS"
    FileUtils.mkdir_p "#{staged_path}/M9A.app/Contents/Resources"
    FileUtils.ln_s Formula["m9a"].libexec/"M9A", "#{staged_path}/M9A.app/Contents/MacOS/M9A"
    system_command "iconutil",
      args: [
        "-c", "icns",
        "#{staged_path}/M9A.iconset",
        "-o", "#{staged_path}/M9A.app/Contents/Resources/M9A.icns"
      ]

    (staged_path/"M9A.app/Contents/Info.plist").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleName</key>
        <string>M9A</string>
        <key>CFBundleDisplayName</key>
        <string>M9A</string>
        <key>CFBundleIdentifier</key>
        <string>io.github.balthild.m9a-stub</string>
        <key>CFBundleVersion</key>
        <string>1.0.0</string>
        <key>CFBundleExecutable</key>
        <string>M9A</string>
        <key>CFBundleIconFile</key>
        <string>M9A</string>
      </dict>
      </plist>
    XML
  end
end
