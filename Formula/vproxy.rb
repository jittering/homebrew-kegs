class Vproxy < Formula
  desc "zero-config virtual proxies with tls"
  homepage "https://github.com/jittering/vproxy"
  version "0.3.0"

  if OS.mac?
    url "https://github.com/jittering/vproxy/releases/download/v#{version}/vproxy_#{version}_Darwin_x86_64.tar.gz"
    sha256 "71cc72980c85e7b7a8f2fe126729bd0eb80377a57bdd274b012d9cc824f5dd88"
  elsif OS.linux?
    url "https://github.com/jittering/vproxy/releases/download/v#{version}/vproxy_#{version}_Linux_x86_64.tar.gz"
    sha256 "58167e289f8c6dc04613649dc4e88197b321d8c146afd0783a7e58d4058a4e06"
  end

  def install
    bin.install "vproxy" => "vproxy"

    File.open("#{etc}/vproxy.conf", "w") do |f|
      f.puts <<-EOF
# Sample config file
EOF
    end
  end

  plist_options :startup => true

	def plist
		<<~EOS
			<?xml version="1.0" encoding="UTF-8"?>
			<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
			<plist version="1.0">
				<dict>
					<key>KeepAlive</key>
					<dict>
						<key>SuccessfulExit</key>
						<false/>
					</dict>
					<key>Label</key>
					<string>#{plist_name}</string>
					<key>ProgramArguments</key>
					<array>
						<string>#{opt_bin}/vproxy</string>
					</array>
					<key>RunAtLoad</key>
					<true/>
					<key>WorkingDirectory</key>
					<string>#{var}</string>
					<key>StandardErrorPath</key>
					<string>#{var}/log/vproxy.log</string>
					<key>StandardOutPath</key>
					<string>#{var}/log/vproxy.log</string>
				</dict>
			</plist>
		EOS
	end

  test do
    system "vproxy", "--help"
  end
end
