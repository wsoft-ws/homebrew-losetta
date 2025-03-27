class Alice < Formula
    desc "Execution environment and command-line interface for AliceScript"
    homepage "https://docs.wsoft.ws/products/alice"
    url "https://github.com/wsoft-ws/Losetta/archive/refs/tags/0.10.6.tar.gz"
    sha256 "a66b8350ac803bc3f52e78bd5f61ecc54bb56a96d18cb64fcbbb7b4da6b139b0"
    license "MIT"
  
    depends_on "dotnet" => :build
  
    def install
      system "dotnet", "publish", "./alice/alice.csproj", "--use-current-runtime", "--verbosity", "quiet", "--self-contained", "-p:PublishSingleFile=true", "--configuration", "Release", "--output", "bin"
      system "bin/alice", "-e", "Alice.Shell.Init"
      bin.install "bin/alice" => "alice"
      bin.install "bin/.alice" => ".alice"
    end
  
    test do
      expect = "Hello,World"
      assert_equal expect, shell_output("#{bin}/alice -e \"print('Hello,World')\"").strip
    end
end
  