require "language/go"

class Ynetd < Formula
  desc "A tiny super server written in go"
  homepage "https://github.com/rwstauner/ynetd"
  url "https://github.com/rwstauner/ynetd.git", :tag => "v0.11"
  head "https://github.com/rwstauner/ynetd.git", :branch => "master"

  depends_on "go" => :build

  go_resource "github.com/hashicorp/go-reap" do
    url "https://github.com/hashicorp/go-reap.git"
  end

  go_resource "gopkg.in/yaml.v2" do
    url "https://gopkg.in/yaml.v2.git"
  end

  go_resource "golang.org/x/sys" do
    url "https://go.googlesource.com/sys.git"
  end

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/rwstauner/ynetd"
    dir.install buildpath.children
    Language::Go.stage_deps resources, buildpath/"src"
    cd dir do
      system "go", "build", "-ldflags", "-X main.Version=v#{version}", "-o", bin/"ynetd"
    end
  end

  test do
    system bin/"ynetd", "--version"
  end
end
