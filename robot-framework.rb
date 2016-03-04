class RobotFramework < Formula
  desc "Open source test framework for acceptance testing"
  homepage "http://robotframework.org/"
  url "https://github.com/robotframework/robotframework/archive/3.0.tar.gz"
  sha256 "1b830fa5e4470ff6b2d404bd99b357cfce4a2abd15c255373045a77d44e517a5"
  revision 1

  head "https://github.com/robotframework/robotframework.git", :branch => "master"
  bottle do
    cellar :any_skip_relocation
    sha256 "b40a511ae02549250f6bf450e5cbd220b6a518bd6228eb06cb22a4485f5561a4" => :el_capitan
    sha256 "c377d897c23190160d0783514365274a60436fb91e7317db5673912fdf2d7e90" => :yosemite
    sha256 "d2dcf8ecc30acaefff2349f54e3c9938180708b6f99881f9eca5411c618cac98" => :mavericks
  end

  depends_on :x11
  depends_on :python if MacOS.version <= :snow_leopard

  resource "selenium" do
    url "https://pypi.python.org/packages/source/s/selenium/selenium-2.51.1.tar.gz"
    sha256 "05671887f59206abc04d16496c0a3d92ee08497abfc8328a6811eab326fd61a8"
  end

  resource "robotframework-selenium2library" do
    url "https://pypi.python.org/packages/source/r/robotframework-selenium2library/robotframework-selenium2library-1.7.4.tar.gz"
    sha256 "4332e3021c6e4ba4a04f4dd99c4fb970315d9fc0fe31bcb62aad2fe833ad9400"
  end

  resource "decorator" do
    url "https://pypi.python.org/packages/source/d/decorator/decorator-4.0.6.tar.gz"
    sha256 "1c6254597777fd003da2e8fb503c3dbf3d9e8f8d55f054709c0e65be3467209c"
  end

  resource "pycrypto" do
    url "https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz"
    sha256 "f2ce1e989b272cfcb677616763e0a2e7ec659effa67a88aa92b3a65528f60a3c"
  end

  resource "ecdsa" do
    url "https://pypi.python.org/packages/source/e/ecdsa/ecdsa-0.13.tar.gz"
    sha256 "64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa"
  end

  resource "paramiko" do
    url "https://pypi.python.org/packages/source/p/paramiko/paramiko-1.16.0.tar.gz"
    sha256 "3297ebd3cd072f573772f7c7426939a443c62c458d54bb632ff30fd6ecf96892"
  end

  resource "robotframework-sshlibrary" do
    url "https://pypi.python.org/packages/source/r/robotframework-sshlibrary/robotframework-sshlibrary-2.1.2.tar.gz"
    sha256 "aebb57c7b4495f0a3b53e4c111400cdd9d7ebfdfb62af82ca720c727de95803d"
  end

  resource "robotframework-archivelibrary" do
    url "https://pypi.python.org/packages/source/r/robotframework-archivelibrary/robotframework-archivelibrary-0.3.2.tar.gz"
    sha256 "a9b2db827209f53fac77cb5f98b04e655e0933dd607d63da37765e44ebb374f2"
  end

  resource "requests" do
    url "https://pypi.python.org/packages/source/r/requests/requests-2.9.1.tar.gz"
    sha256 "c577815dd00f1394203fc44eb979724b098f88264a9ef898ee45b8e5e9cf587f"
  end

  resource "requests_kerberos" do
    url "https://pypi.python.org/packages/source/r/requests-kerberos/requests-kerberos-0.8.0.tar.gz"
    sha256 "f3ce6e70e19080fe146245f1c663e73a3868fbb087142962b91c5396fa051b1a"
  end

  resource "kerberos" do
    url "https://pypi.python.org/packages/source/k/kerberos/kerberos-1.2.4.tar.gz"
    sha256 "d6f49923bbcf4ebc47ae47b7ceac7866543200669e1dfb24821221da3e940987"
  end

  def install
    vendor_site_packages = libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", vendor_site_packages
    resources.each do |r|
      r.stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    (testpath/"HelloWorld.txt").write <<-EOF.undent
      *** Settings ***
      Library         HelloWorld.py

      *** Test Cases ***
      HelloWorld
          Hello World
    EOF

    (testpath/"HelloWorld.py").write <<-EOF.undent
      def hello_world():
          print "HELLO WORLD!"
    EOF
    system bin/"pybot", testpath/"HelloWorld.txt"
  end
end
