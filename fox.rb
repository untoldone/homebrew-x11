class Fox < Formula
  desc "Toolkit for developing Graphical User Interfaces easily."
  homepage "http://www.fox-toolkit.org/"
  url "http://ftp.fox-toolkit.org/pub/fox-1.6.51.tar.gz"
  sha256 "15a99792965d933a4936e48b671c039657546bdec6a318c223ab1131624403d1"

  bottle do
    cellar :any
    sha256 "9e3befd8d4b812cd69ef245372464947ae6b69f4faae2fe51bccc304b2061a29" => :el_capitan
    sha256 "ceb3a636b4af6abe6ffbaa7308ec3280b3e15571734d14218580791a24dfdc4f" => :yosemite
    sha256 "e06e4713c4bd87fb0fa792d151759d3785d4dcdb5c08953f8c857d104ed14501" => :mavericks
  end

  depends_on :x11
  depends_on "freetype"
  depends_on "libpng"
  depends_on "jpeg"
  depends_on "libtiff"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--enable-release",
                          "--prefix=#{prefix}",
                          "--with-x",
                          "--with-opengl"
    # Unset LDFLAGS, "-s" causes the linker to crash
    system "make", "install", "LDFLAGS="
    rm bin/"Adie.stx"
  end

  test do
    system bin/"reswrap", "-t", "-o", "text.txt", test_fixtures("test.jpg")
    assert_match "\\x00\\x85\\x80\\x0f\\xae\\x03\\xff\\xd9", File.read("text.txt")
  end
end
