class Uv < Formula
  desc "Extremely fast Python package installer and resolver, written in Rust"
  homepage "https://github.com/astral-sh/uv"
  url "https://github.com/astral-sh/uv/archive/refs/tags/0.4.19.tar.gz"
  sha256 "2b6f54d67249e941c6bb684cdd03f01b542fbd93e98ec244c530f4aa91eda6ab"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/astral-sh/uv.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "381c9ff5dd8eb79df43b79b17417e6e748bb5a6da94f3698718ed40cbfb3eeba"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5c105a1d6beef7b7553437dfaad8f2fe0dbfb057c7990b2f730c56b7820b7e71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "23bdab494e898c18367f60c9054a10a79dd7551980b0ae4c9588b5d38a152350"
    sha256 cellar: :any_skip_relocation, sonoma:        "a793ec90288554c3a6cdae0232d9a372f7e671d6812e57c5e59bdd5fde5a6aab"
    sha256 cellar: :any_skip_relocation, ventura:       "c816c9acb0c2184efd70e2fa7c698963a61bd848b876a4f9558343199a055e2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "363c12043195ac097d7273824f412737dfb0d0b2113addacf2eb6e45a76eb585"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  uses_from_macos "python" => :test
  uses_from_macos "xz"

  on_linux do
    # On macOS, bzip2-sys will use the bundled lib as it cannot find the system or brew lib.
    # We only ship bzip2.pc on Linux which bzip2-sys needs to find library.
    depends_on "bzip2"
  end

  def install
    ENV["UV_COMMIT_HASH"] = ENV["UV_COMMIT_SHORT_HASH"] = tap.user
    ENV["UV_COMMIT_DATE"] = time.strftime("%F")
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "crates/uv")
    generate_completions_from_executable(bin/"uv", "generate-shell-completion")
    generate_completions_from_executable(bin/"uvx", "--generate-shell-completion", base_name: "uvx")
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      requests
    EOS

    compiled = shell_output("#{bin}/uv pip compile -q requirements.in")
    assert_match "This file was autogenerated by uv", compiled
    assert_match "# via requests", compiled

    assert_match "ruff 0.5.1", shell_output("#{bin}/uvx -q ruff@0.5.1 --version")
  end
end
