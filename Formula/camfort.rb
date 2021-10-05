class Camfort < Formula
  VERSION = "1.1.1".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "https://camfort.github.io"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "4e18389bdaa075d499383dde88c1ccb00f2e695c05622447296a112e5c2d739c"
  license "Apache-2.0"
  head "https://github.com/camfort/camfort.git", branch: "master"

  bottle do
    root_url "https://github.com/raehik/homebrew-camfort/releases/download/camfort-1.1.1"
    sha256 cellar: :any, catalina: "ef0d37ac451e2ce103df6756904be011f429719acc5cae290395c2460003ea28"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  depends_on "flint" => :linked
  depends_on "z3" => :linked

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    # Test to see if units-suggest runs without errors
    crit_units_test = testpath / "crit_units_test.f90"
    crit_units_test.write <<-EOF
      program crit_units_test
        integer x, y, z
        x = y * z
      end program crit_units_test
    EOF

    system bin / "camfort", "units-suggest", crit_units_test
  end
end
