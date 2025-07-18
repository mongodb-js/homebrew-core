class Odt2txt < Formula
  desc "Convert OpenDocument files to plain text"
  homepage "https://github.com/dstosberg/odt2txt/"
  url "https://github.com/dstosberg/odt2txt/archive/refs/tags/v0.5.tar.gz"
  sha256 "23a889109ca9087a719c638758f14cc3b867a5dcf30a6c90bf6a0985073556dd"
  license "GPL-2.0-only"

  no_autobump! because: :requires_manual_review

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "306d55c929e1ac95e7e4a0ae181c666b460e1e733ee3bedc106fa95f06187724"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f4fc587af2f55d58d15ab56763d66b80a471c9e3db19fd58c48e923f02b55a5a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6da6cd6c262ef01c0f0c7cf9de4e4897f255bcf5266313a373c6b89ebc15d162"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1990d5bd2ed1d5d9b5f7165ecd8285ded82ff8ed0d622b5f9820e9bc2123252c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "00a813eeef30b44f3c760435055a40f5471aa64fac6f390fcbc5bea64f34e9cd"
    sha256 cellar: :any_skip_relocation, sonoma:         "6d6065192c2e3550077b108fde9b902659bb8ad16996e9a0295900e5301ce13e"
    sha256 cellar: :any_skip_relocation, ventura:        "d0beae42729ad6c48197a6575aa419f1c9b9c742252ce70b3105a3d19a2a6815"
    sha256 cellar: :any_skip_relocation, monterey:       "0567b8e8d71e49da55816d890481a29b0a173a88ec59ab5141a2b7581cff8e0c"
    sha256 cellar: :any_skip_relocation, big_sur:        "255a40ee5035ec02702587440eee33cbfd83d110daf1c90a965c4de5f92a34f0"
    sha256 cellar: :any_skip_relocation, catalina:       "31e17f05898b06469cbc33244f357c61baf059120e96b34d472325e38adfa4d7"
    sha256 cellar: :any_skip_relocation, mojave:         "eb4ea913c8c1f5108adae12acf43ada9033c3bdd2e6976fcce9726108b47df2b"
    sha256 cellar: :any_skip_relocation, high_sierra:    "02dd0957fda7e5845824951a3e98d2ac9a1a623a02709631d26496bbe0353dee"
    sha256 cellar: :any_skip_relocation, sierra:         "88fb433f9e72c6c727f9af5ff017d6bac07f29bc64bfa59f6b53d4ab52f42cb3"
    sha256 cellar: :any_skip_relocation, el_capitan:     "4b86c07be0d96899d76adee3bf65390beb4288eeddbfb531dfcdbc3f17ff5bc8"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "21cf6bcd55e7daf00c9ad24283385b8d8a6e9070b840431d228cf815f51c411b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b48cef7a1fb7bf172435fbf6b465ea9fde29785f9be3d088075ad0e5224cfab"
  end

  uses_from_macos "zlib"

  def install
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    resource "homebrew-sample" do
      url "https://github.com/Turbo87/odt2txt/raw/samples/samples/sample-1.odt"
      sha256 "78a5b17613376e50a66501ec92260d03d9d8106a9d98128f1efb5c07c8bfa0b2"
    end

    testpath.install resource("homebrew-sample")
    system bin/"odt2txt", "sample-1.odt"
  end
end
