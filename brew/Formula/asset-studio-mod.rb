class AssetStudioMod < Formula
  desc "Modified version of Perfare's AssetStudio"
  homepage "https://github.com/aelurum/AssetStudio"

  version "0.19.0"
  url "https://github.com/aelurum/AssetStudio/releases/download/v#{version}/AssetStudioModCLI_net9_mac64.zip"

  depends_on "dotnet-runtime-x64"

  def install
    libexec.install Dir["*"]
    (libexec/"AssetStudioModCLI").chmod 0755

    (bin/"AssetStudioModCLI").write_env_script libexec/"AssetStudioModCLI",
      DOTNET_ROOT: Formula["dotnet-runtime-x64"].libexec
  end
end
