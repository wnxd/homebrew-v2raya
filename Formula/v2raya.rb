class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "2.2.4.3"
    
    $v2rayA_version = "2.2.4.3"
    $url_linux_x64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "56e92e9f2edbedec0cd66cf15d5baff79ad1d276d988317b6f0e2f11ac78c1bf"
    $url_macos_x64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "d3fa3e23658be077b866e5f88b552aecc48abe4ef112afb615bafd5dbcd68df0"
    $url_macos_arm64 = "https://github.com/wnxd/homebrew-v2raya/releases/download/2.2.4.3/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "0063f61adb7f1fdf86a740b66bd6af117ea2dee6e51be2e8dc9f50875a038891"

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
      environment_variables V2RAYA_CONFIG: "#{opt_pkgshare}", V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share", PATH: "/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:#{HOMEBREW_PREFIX}/bin:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
