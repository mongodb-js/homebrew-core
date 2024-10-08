class Vcprompt < Formula
  desc "Provide version control info in shell prompts"
  homepage "https://hg.gerg.ca/vcprompt"
  url "https://hg.gerg.ca/vcprompt/archive/1.2.1.tar.gz"
  sha256 "fdf26566e2bd73cf734b7228f78c09a0f53d0166662fcd482a076ed01c9dbe36"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://hg.gerg.ca/vcprompt/tags"
    regex(%r{href=.*?/v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "19274660bf8229fb34bc9da7f0cd03ea347ae45e5f17c09a5d39f95a64db4bf3"
    sha256 cellar: :any,                 arm64_sonoma:   "a10dc2ebe159bd795426b839d126aae6e514f8fdc6710315cf4d4369e9616eab"
    sha256 cellar: :any,                 arm64_ventura:  "dabda586720b4a2e74cc9d64c4f53f306e589e6a213f9b906fd65e6df0135edc"
    sha256 cellar: :any,                 arm64_monterey: "68f6b1d5918c5abed9e6412109d5964f5b0652464b258dd236d31235f5b56cf3"
    sha256 cellar: :any,                 arm64_big_sur:  "2aaf6bc2c4bd41f4732aab8837c892a0f8f179b8db58ceff29dd38919d7d830d"
    sha256 cellar: :any,                 sonoma:         "6d6810f9bb14745dda1627ef8ffa2502462a4ef2edf5089c757234ba6dda3e2a"
    sha256 cellar: :any,                 ventura:        "efee1589bcaf744a2dc8b2c4950a9776713c57cdef7070dc6ac99a108a387b12"
    sha256 cellar: :any,                 monterey:       "7fad40a3ea9f1ce2caa8791db819c896841d8be00c8f1fdd47b6fa7991e47421"
    sha256 cellar: :any,                 big_sur:        "571cb1cb75d76851cfe86e8622a2085e87d1cc292147b246410b61ac40f86dff"
    sha256 cellar: :any,                 catalina:       "503cb9532dff8fc7eb8fdd11291b26ba3240ce304e4bcb5e9888a35161433ac5"
    sha256 cellar: :any,                 mojave:         "8be8d7b1126e40a72a85f707b07f922132769cb2c6c26f768fe57ccb9c542fa5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "96c7865a3e44409abbf55dd2cccaff06555f9460b89c07ce958a86d534e28487"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "sqlite"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "PREFIX=#{prefix}",
                   "MANDIR=#{man1}",
                   "install"
  end

  test do
    system bin/"vcprompt"
  end
end
