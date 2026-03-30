class DotnetRuntimeX64 < Formula
  desc "Microsoft .NET Runtime for x64 architecture"
  homepage "https://dotnet.microsoft.com/download/dotnet"

  version "9.0.14"
  url "https://builds.dotnet.microsoft.com/dotnet/Runtime/#{version}/dotnet-runtime-#{version}-osx-x64.tar.gz"

  def install
    libexec.install Dir["*"]
  end
end
