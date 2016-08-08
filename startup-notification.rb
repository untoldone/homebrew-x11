class StartupNotification < Formula
  desc "Reference implementation of the startup notification protocol"
  homepage "https://www.freedesktop.org/wiki/Software/startup-notification/"
  url "https://www.freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz"
  sha256 "3c391f7e930c583095045cd2d10eb73a64f085c7fde9d260f2652c7cb3cfbe4a"

  bottle do
    cellar :any
    sha256 "bf0617cbc21520cb97f94b65ef5f873054d5d59014faf07a1073ae6bcaea3477" => :el_capitan
    sha256 "3467658602936b5da997b5d5cbca665f1b119d74f9bdbf3728e16e46d5cbc9ec" => :yosemite
    sha256 "1338de9f5b45bcfa1f4741774ade40c3208b0811f4cce112ec2b5d1672f2cb71" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on :x11

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
