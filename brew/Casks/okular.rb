cask "okular" do
  name "Okular"
  desc "The Universal Document Viewer"
  homepage "https://okular.kde.org/"

  version "25.12-7123"
  url "https://cdn.kde.org/ci-builds/graphics/okular/release-25.12/macos-arm64/okular-release_25.12-7123-macos-clang-arm64.dmg"

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  app "okular.app"

  zap trash: [
    "~/Library/Preferences/org.kde.okular.plist",
    "~/Library/Saved Application State/org.kde.okular.savedState",
  ]
end
