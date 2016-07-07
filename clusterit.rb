class Clusterit < Formula
  desc "Tools to turn UNIX workstations into speedy parallel beasts"
  homepage "http://www.garbled.net/clusterit.html"
  url "https://downloads.sourceforge.net/project/clusterit/clusterit/clusterit-2.5/clusterit-2.5.tar.gz"
  sha256 "e50597fb361d9aefff0250108900a3837a4a14c46083d6eb5ed5d7fc42ce9f35"

  depends_on :x11

  conflicts_with "couchdb-lucene", :because => "both install a `run` binary"
  conflicts_with "pdsh", :because => "both install `dshbak`"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # `run` is too generic a name to be placed in top-level bin.
    mv bin/"run", bin/"clusterit-run"
  end

  def caveats; <<-EOS.undent
    The `run` executable was symlinked into bin as `clusterit-run` to
    avoid putting a generically-named executable in the top-level prefix.
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/barrierd -v")
  end
end
