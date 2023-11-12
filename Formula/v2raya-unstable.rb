class V2rayaUnstable < Formula
  desc "Web-based GUI client of Project V"
  homepage "https://v2raya.org"
  license "AGPL-3.0-only"
  version "20231112.r1468.a62fba55"
  
  $v2raya_version = "20231112.r1468.a62fba55"
  $url_linux_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6840660852/v2raya_linux_x64_unstable-20231112.r1468.a62fba55.zip"
  $sha_linux_x64 = "c737db69fa6361bdda143a4e34f61012195aadf6210e24370eecbace9dc9b823"
  $url_macos_x64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6840660852/v2raya_darwin_x64_unstable-20231112.r1468.a62fba55.zip"
  $sha_macos_x64 = "508ba0478b9e76bbf3fc37e61530a07def3e37e56d3db4e34a466d27dfebea79"
  $url_macos_arm64 = "https://nightly.link/v2rayA/v2rayA/actions/runs/6840660852/v2raya_darwin_arm64_unstable-20231112.r1468.a62fba55.zip"
  $sha_macos_arm64 = "847ac6ee54e34aa334c46126dcbfc7de0cf42b9647934a1637d02b94c597162d"

  if OS.linux?
    url $url_linux_x64
    sha256 $sha_linux_x64
    $os_type = "linux_x64"
  elsif Hardware::CPU.intel?
    url $url_macos_x64
    sha256 $sha_macos_x64
    $os_type = "darwin_x64"
  else
    url $url_macos_arm64
    sha256 $sha_macos_arm64
    $os_type = "darwin_arm64"
  end

  depends_on "v2ray"

  def install
    bin.install "v2raya_#{$os_type}_unstable-#{version}" => "v2raya-unstable"
    puts "v2raya-unstable installed, don't run both v2raya and v2raya-unstable service at the same time, or write launchd's plist file yourself to specify ports used by v2raya-unstable."
    puts "If you forget your password, stop running v2raya-unstable, then run `v2raya-unstable --lite --reset-password` to reset password."
  end

  service do
    environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya-unstable.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
    run [bin/"v2raya-unstable", "--lite"]
    keep_alive true
  end
end
