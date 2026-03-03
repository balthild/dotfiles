class M9a < Formula
  desc "Assistant For Reverse: 1999"
  homepage "https://github.com/MAA1999/M9A"
  license "AGPL-3.0-only"

  version "v3.20.1"
  url "https://github.com/MAA1999/M9A/releases/download/#{version}/M9A-macos-aarch64-#{version}-MXU.tar.gz"

  def install
    libexec.install Dir["*"]
  end
end
