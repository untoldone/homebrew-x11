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

  devel do
    url "https://github.com/FreeRDP/FreeRDP/archive/4c69c3ea1489f09e1c3e698eaebd67b6d8d25785.tar.gz" # stable-1.1 branch as of Aug 13, 2016
    sha256 "4a3a2cbb8d5dd2660252c1dc03ddfbdce8a23423d09c01b590cc94390a31e476"
    version "1.1.0-beta1"
    depends_on :xcode => :build # for "ibtool"

    patch do
      url "https://github.com/untoldone/FreeRDP/commit/65e53694eb5d6faa5d57a31a54defd1c5233ac09.diff"
      sha256 "a017305311312006d253908615a7af29c5f71a0cf2dcea1de9e35616a9df3d00"
    end
  end

  head do
    url "https://github.com/FreeRDP/FreeRDP.git"
    depends_on :xcode => :build

    patch do
      url "https://github.com/untoldone/FreeRDP/commit/75a483d1a5a6b931a4575b63bf2a3705cd9038f6.diff"
      sha256 "436120da99d4fb7136797820bd4ab74a7e57f15cddeea46ee0698ccc7c7c4a26"
    end
  end

  depends_on :x11
  depends_on "openssl"
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DWITH_X11=ON" << "-DBUILD_SHARED_LIBS=ON" if build.head? || build.devel?
    system "cmake", ".", *cmake_args
    system "make", "install"
  end

  test do
    success = `#{bin}/xfreerdp --version` # not using system as expected non-zero exit code
    details = $?
    if !success && details.exitstatus != 128
      raise "Unexpected exit code #{$?} while running xfreerdp"
    end
  end
end
