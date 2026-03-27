cask "playcover-maa" do
  name "PlayCover MAA"
  desc "A fork of PlayCover with MAA support"
  homepage "https://github.com/hguandl/PlayCover"

  version "3.1.0.maa.3"
  url "https://github.com/hguandl/PlayCover/releases/download/v#{version}/PlayCover-v#{version}.dmg"

  conflicts_with cask: ["playcover-community", "playcover-community@beta"]
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "PlayCover.app"

  zap trash: [
    "~/Library/Application Support/io.playcover.PlayCover",
    "~/Library/Caches/io.playcover.PlayCover",
    "~/Library/Containers/io.playcover.PlayCover",
    "~/Library/Frameworks/PlayTools.framework",
    "~/Library/Preferences/io.playcover.PlayCover.plist",
    "~/Library/Saved Application State/io.playcover.PlayCover.savedState",
  ]
end
