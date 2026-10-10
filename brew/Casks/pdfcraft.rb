cask "pdfcraft" do
  name "PdfCraft"
  desc "An open-source, clean-room reimplementation of Adobe Acrobat"
  homepage "https://github.com/storytold/pdfcraft"

  version "0.4.0"
  url "https://github.com/storytold/pdfcraft/releases/download/v#{version}/pdfcraft-#{version}-macos-universal.dmg"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "PdfCraft.app"
end
