class Feh < Formula
  desc "X11 image viewer"
  homepage "https://feh.finalrewind.org/"
  url "https://feh.finalrewind.org/feh-2.16.1.tar.bz2"
  sha256 "6e55289a3be4495a437a0b037c7b5e86edf64ec74ab63d2d26fa50df1b62b6b3"

  bottle do
    sha256 "d1ef5da4700c6e1bf942b069eb5c7e6b7a9d6d93a088e45343d0179b085a01eb" => :el_capitan
    sha256 "4af6a153a0964d31a5e3127faa5465a54f0e7912da549ba171f37c48e4877de8" => :yosemite
    sha256 "ad30b3fc1efe13f5aa2ebeb4e83c82cdd439ac1cbe1b68289a9892e96595f06a" => :mavericks
  end

  depends_on :x11
  depends_on "imlib2"
  depends_on "libexif" => :recommended

  def install
    args = []
    args << "exif=1" if build.with? "libexif"
    system "make", "PREFIX=#{prefix}", *args
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/feh -v")
  end
end
