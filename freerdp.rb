class Freerdp < Formula
  desc "X11 implementation of the Remote Desktop Protocol (RDP)"
  homepage "http://www.freerdp.com/"
  revision 1

  stable do
    url "https://github.com/FreeRDP/FreeRDP/archive/1.0.2.tar.gz"
    sha256 "c0f137df7ab6fb76d7e7d316ae4e0ca6caf356e5bc0b5dadbdfadea5db992df1"

    patch do
      url "https://github.com/FreeRDP/FreeRDP/commit/1d3289.diff"
      sha256 "90a4f288349dd13b658b3401762373f0dec8414233bf304df0715724c8352cec"
    end

    patch do
      url "https://github.com/FreeRDP/FreeRDP/commit/e32f9e.diff"
      sha256 "1b8ec9d5e229b4ed50790042bee7ceb3e85bdd88c9bc2dcfdf2e9d97e921649d"
    end

    # https://github.com/FreeRDP/FreeRDP/pull/1682/files
    patch do
      url "https://gist.githubusercontent.com/bmiklautz/8832375/raw/ac77b61185d11aa69e5f6b5e88c0fa597c04d964/freerdp-1.0.2-osxversion-patch.diff"
      sha256 "2e8f68a0dbe6e2574dec3353e65a4f03d76a3398f8fac536fda08c24748aec2b"
    end
  end

  bottle do
    sha256 "a9dcd06b038eec6a842f736b4d094cd2dc397bb43db94d815da4920418c31d5f" => :el_capitan
    sha256 "6ccbfe9611778eb735dcdc425fb50272fdcd97f637d43376a45a348786bd12ba" => :yosemite
    sha256 "31bba49df55d694d026ec8735f8e12ce83fb549fc70383bc2a4d3f60f13841fe" => :mavericks
  end

  head do
    url "https://github.com/FreeRDP/FreeRDP.git"
    depends_on :xcode => :build # for "ibtool"
  end

  depends_on :x11
  depends_on "openssl"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DWITH_X11=ON" if build.head?
    system "cmake", ".", *cmake_args
    system "make", "install"
  end

  test do
    success = `#{bin}/xfreerdp --version` # not using system as expected non-zero exit code
    details = $?
    if details.exitstatus != 128
      raise "Unexpected exit code #{$?} while running xfreerdp"
    end
  end
end
