cask "m9a" do
  name "M9A"
  desc "Assistant For Reverse: 1999"
  homepage "https://github.com/MAA1999/M9A"

  version "4.14.0"
  url "https://github.com/MAA1999/M9A/releases/download/v#{version}/M9A-macos-aarch64-v#{version}-MXU.dmg"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "M9A.app"

  preflight_steps do
		run "xattr", args: [
			"-rd", "com.apple.quarantine",
			"{{staged_path}}/M9A.app",
		]
  end
end
