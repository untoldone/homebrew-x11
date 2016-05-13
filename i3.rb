class I3 < Formula
  desc "Tiling window manager"
  homepage "http://i3wm.org/"
  url "http://i3wm.org/downloads/i3-4.12.tar.bz2"
  sha256 "e19e1ce08c2549cba83e083cc768d487202c41760d5c283f67752e791f1d78b4"
  head "https://github.com/i3/i3.git"

  bottle do
    sha256 "58fdbcfd0a9bf073c760de62934f73358fdd6e2f8f0b66f173cc5011a544ea19" => :el_capitan
    sha256 "e2d93d7af5a873457217403dcba6555fc8868af29de07823f78d2ee184b9f8bb" => :yosemite
    sha256 "5f5c96db7bb11a7cb3003bca56d990b3a6b8d874671355866a7d378442e6f044" => :mavericks
  end

  depends_on "asciidoc" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo" => ["with-x11"]
  depends_on "gettext"
  depends_on "libev"
  depends_on "pango"
  depends_on "pcre"
  depends_on "startup-notification"
  depends_on "yajl"
  depends_on :x11
  depends_on "libxkbcommon"

  def install
    # In src/i3.mk, precompiled headers are used if CC=clang, however superenv
    # currently breaks the clang invocation, setting CC=cc works around this.
    system "make", "install", "CC=cc", "PREFIX=#{prefix}"
    man1.install Dir["man/*.1"]
  end

  test do
    result = shell_output("#{bin}/i3 -v")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_match "#{version}", result
  end
end
