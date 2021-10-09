class Camfort < Formula
  VERSION = "1.1.2".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "https://camfort.github.io"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "d2b16259b486faf90c4a6144ae19ff94e02bd69d5e97773effb1244724e9468d"
  license "Apache-2.0"
  head "https://github.com/camfort/camfort.git", branch: "master"

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
