class Xlispstat < Formula
  desc "Statistical data science environment based on Lisp"
  homepage "http://homepage.stat.uiowa.edu/~luke/xls/xlsinfo/"
  url "http://homepage.cs.uiowa.edu/~luke/xls/xlispstat/current/xlispstat-3-52-23.tar.gz"
  version "3.52.23"
  sha256 "9bf165eb3f92384373dab34f9a56ec8455ff9e2bf7dff6485e807767e6ce6cf4"
  bottle do
    cellar :any_skip_relocation
    sha256 "1f6d4e8a46960c6b8d6280468cdd139fd461ef8d04665a201ee4b4123bca8f60" => :el_capitan
    sha256 "c8ce61126f5d7fba847ff9acda2e71dc3858627caf12570927e4582ba795e44d" => :yosemite
    sha256 "0d2b871e5392161cba7fe59748fa1c2ac61da3189981fa10d8403d46c474c5bd" => :mavericks
  end

  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    ENV.j1 # Or make fails bytecompiling lisp code
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "> 50.5\n> ", pipe_output("#{bin}/xlispstat | tail -2", "(median (iseq 1 100))")
  end
end
