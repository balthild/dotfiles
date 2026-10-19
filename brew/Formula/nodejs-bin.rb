class NodejsBin < Formula
  desc "Prebuilt distribution of Node.js"
  homepage "https://nodejs.org"
  license "MIT"

  version "24.22.0"
  url "https://nodejs.org/dist/v#{version}/node-v#{version}-darwin-arm64.tar.xz"
  sha256 "75ddfb875bbd868ebe57536f4442225f54dd10f6d2178dd439de869a5c648dc3"

  depends_on :macos
  depends_on arch: :arm64

  keg_only "skibidi"

  def install
    prefix.install Dir["*"]
  end
end
