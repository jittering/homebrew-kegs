class Vproxy < Formula
  desc "zero-config virtual proxies with tls"
  homepage "https://github.com/chetan/vproxy"
  version "0.3"

  if OS.mac?
    url "https://github.com/chetan/simpleproxy/releases/download/v#{version}/vproxy-macos-x64", :using => :nounzip
    sha256 "597c13acf672b0cd66f1a4e82367ad016d87ae58dff98ac4b4524ece35757f16"
  elsif OS.linux?
    url "https://github.com/chetan/simpleproxy/releases/download/v#{version}/vproxy-linux-x64"
    sha256 "59fb70499801c2e90ded7de4b7335b32d8f23d9ce37c184a1dd784c1b01aa612"
  end

  def install
    if OS.mac?
      bin.install "vproxy-macos-x64" => "vproxy"
    elsif OS.linux?
      bin.install "vproxy-linux-x64" => "vproxy"
    end
  end

  test do
    system "vproxy", "--help"
  end
end
