class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.4.3"
    
    $v2rayA_version = "2.2.4.3"
    $url_linux_x64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "e3391178e8bdda7538aa4550dcd94d410c1610ef858c83cda88e093999ecd0a9"
    $url_macos_x64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "9c691792c80fddb574a5f86fef80e35be2dfb293a82e384e0d0c428db5211908"
    $url_macos_arm64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "265a2fa3a364a13b526ae5c298819ce98169a83fa6ccf903677f4b3dbe351426"

    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
    else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    depends_on "v2ray"

    def install
      bin.install "v2raya"
      puts "If you forget your password, stop running v2raya, then run `v2raya --lite --reset-password` to reset password."
    end

    service do
      environment_variables V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
