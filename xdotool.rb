class Xdotool < Formula
  desc "Fake keyboard/mouse input and window management for X"
  homepage "http://www.semicomplete.com/projects/xdotool/"
  url "https://github.com/jordansissel/xdotool/archive/v3.20160805.1.tar.gz"
  sha256 "ddafca1239075c203769c17a5a184587731e56fbe0438c09d08f8af1704e117a"

  bottle do
    sha256 "eb53a6093737dd0d26cf83a056943da18f438e64216a95f059eb3cc6770bf3fe" => :el_capitan
    sha256 "290fc7273fb6e7c345e59e8a49c6706d51020bb0c1230b032f74f6cca1478c7d" => :yosemite
    sha256 "5d493d2cb2ee8fc42f2eeb5d15370e35ebd1530ea209561a8e6c30ef08807fd0" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "libxkbcommon"

  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "INSTALLMAN=#{man}", "install"
  end

  def caveats; <<-EOS.undent
    You will probably want to enable XTEST in your X11 server now by running:
      defaults write org.x.X11 enable_test_extensions -boolean true

    For the source of this useful hint:
      http://stackoverflow.com/questions/1264210/does-mac-x11-have-the-xtest-extension
    EOS
  end

  test do
    system "#{bin}/xdotool", "--version"
  end
end
