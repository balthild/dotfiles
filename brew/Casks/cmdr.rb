cask "cmdr" do
  name "Cmdr"
  desc "The file-manager macOS deserves"
  homepage "https://github.com/vdavid/cmdr"

  version "0.9.1"
  url "https://github.com/vdavid/cmdr/releases/download/v#{version}/Cmdr_#{version}_aarch64.dmg"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Cmdr.app"
end
