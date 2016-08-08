class Mupdf < Formula
  desc "Lightweight PDF and XPS viewer"
  homepage "http://mupdf.com"
  url "http://mupdf.com/downloads/archive/mupdf-1.8-source.tar.gz"
  sha256 "a2a3c64d8b24920f87cf4ea9339a25abf7388496440f13b37482d1403c33c206"

  bottle do
    cellar :any
    revision 1
    sha256 "78099992df386bf48f24ab6935d6daa52c3dc33a6359cedb8ea8e25fdee307fb" => :el_capitan
    sha256 "d7733d3f510002ec5466440f01e64a34ee9530fb6e3700ed2cbfcb37a50d2597" => :yosemite
    sha256 "9885974afb678510b5c03c9cb2e599776b5c48bccb5abc08f4c245f8737822e0" => :mavericks
  end

  depends_on :macos => :snow_leopard
  depends_on :x11
  depends_on "openssl"

  conflicts_with "mupdf-tools",
    :because => "mupdf and mupdf-tools install the same binaries."

  def install
    system "make", "install",
           "build=release",
           "verbose=yes",
           "CC=#{ENV.cc}",
           "prefix=#{prefix}"
    bin.install_symlink "mutool" => "mudraw"
  end

  test do
    pdf = test_fixtures("test.pdf")
    assert_match /Homebrew test/, shell_output("#{bin}/mudraw -F txt #{pdf}")
  end
end
