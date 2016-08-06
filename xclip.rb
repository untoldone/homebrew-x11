class Xclip < Formula
  desc "Command-line utility that is designed to run on any system with an X11"
  homepage "https://github.com/astrand/xclip"
  url "https://downloads.sourceforge.net/project/xclip/xclip/0.12/xclip-0.12.tar.gz"
  sha256 "b7c7fad059ba446df5692d175c2a1d3816e542549661224806db369a0d716c45"

  bottle do
    cellar :any_skip_relocation
    sha256 "7e3799df54ee05e5b1109492596c5e34feecd2405c29f71338b91373d320bc05" => :el_capitan
    sha256 "c5d2792e9767c7d63597d5c28e4b6822f14b2cd2022edfd42d1c83070c35d5be" => :yosemite
    sha256 "199a2fbb41962c4d02db61faba6c4b363d8c34c4d5512d6e4e1cd9b0543407c7" => :mavericks
  end

  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xclip", "-version"
  end
end
