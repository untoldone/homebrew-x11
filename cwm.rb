class Cwm < Formula
  desc "Portable version of OpenBSD's cwm(1) window manager"
  homepage "https://github.com/chneukirchen/cwm"
  head "https://github.com/chneukirchen/cwm.git"

  stable do
    url "https://github.com/chneukirchen/cwm/archive/v5.6.tar.gz"
    sha256 "006320bb1716cc0f93bac5634dcccd01f21d468263b5fc9d1be2dd11078a0625"

    patch do
      # Fix 10.10 build. Merged upstream.
      url "https://github.com/chneukirchen/cwm/commit/81c05b3.diff"
      sha256 "d801f8536885bdda82f724b6b30c26af5e8967490e1c0b6419933b2341688db4"
    end
  end

  bottle do
    cellar :any
    sha256 "66505c17dbe6aabfc53d2cfd0d9b09f77ca384637ffcf99a209e0c87f6b37a85" => :yosemite
    sha256 "9665155b0132c3fd248bb81d44204b90e8b352fb82054b238b98d7223a92abdd" => :mavericks
    sha256 "895d906f52d9eca0a83a290bcb1499343ecf91b22cbee77f0494a39239fa7859" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end
end
