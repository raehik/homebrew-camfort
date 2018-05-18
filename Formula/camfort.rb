require "language/haskell"

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  VERSION = "0.905".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "https://camfort.github.io"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "65242679050d2107586ec08890107cb9da6e46890768bfa056cf46ad674f9793"

  head "https://github.com/camfort/camfort.git"

  # bottle do
  #   root_url "https://github.com/camfort/camfort/releases/download/v#{VERSION}"
  #  cellar :any
  #  sha256 "" => :sierra
  # end

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "gsl" => :linked
  depends_on "pcre" => :linked
  depends_on "gmp" => :linked
  depends_on "z3" => :linked
  depends_on "brewsci/science/flint" => :linked

  def install
    install_cabal_package :using => %w[alex happy]
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
