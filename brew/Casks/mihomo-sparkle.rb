cask "mihomo-sparkle" do
  name "Sparkle"
  desc "Another Mihomo GUI"
  homepage "https://github.com/xishang0128/sparkle"

  version "1.26.8"
  url "https://github.com/xishang0128/sparkle/releases/download/#{version}/sparkle-macos-#{version}-arm64.pkg"

  depends_on arch: :arm64
  depends_on macos: :monterey

  pkg "sparkle-macos-#{version}-arm64.pkg"

  uninstall pkgutil: "sparkle.app"
end
