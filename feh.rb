class Feh < Formula
  desc "X11 image viewer"
  homepage "https://feh.finalrewind.org/"
  url "https://feh.finalrewind.org/feh-2.16.1.tar.bz2"
  sha256 "6e55289a3be4495a437a0b037c7b5e86edf64ec74ab63d2d26fa50df1b62b6b3"

  bottle do
    sha256 "589af770bac5f344cc962afa18342a003907d552b6820718b25f6319c93e92c3" => :yosemite
    sha256 "78e3ff8d6f8383b267ba63ad5f7ce1a897195d221470c50c673ac9810f72ca3c" => :mavericks
    sha256 "4a968f56ee778297f169d700ceae93d3c9821f074aed592f09d59ec9c27bd6f3" => :mountain_lion
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
