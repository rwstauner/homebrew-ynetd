# rubocop: disable all

class Ynetd < Formula
  desc "micromanage your microservices with a tiny super server written in go"
  homepage "https://github.com/rwstauner/ynetd"
  url "https://github.com/rwstauner/ynetd.git", :tag => "v0.14"
  head "https://github.com/rwstauner/ynetd.git", :branch => "master"

  depends_on "go" => :build

  def install
    ENV.delete("GOPATH")
    ENV["GO111MODULE"] = "on"
    cd buildpath do
      system "go", "build", "-ldflags", "-X main.Version=v#{version}", "-o", bin/"ynetd"
    end
  end

  test do
    system bin/"ynetd", "--version"
  end
end
