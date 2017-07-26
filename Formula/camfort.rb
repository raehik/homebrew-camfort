require "language/haskell"

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  VERSION = "0.904".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "https://camfort.github.io"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "28c6dd7134e79acefe3abb1b6b95c3f5200610a136d4257428e16847d84e3548"

  head "https://github.com/camfort/camfort.git"

  bottle do
    root_url "https://github.com/camfort/camfort/releases/download/v#{VERSION}"
    cellar :any
    sha256 "2ac9f35b0fb3b9d08a09c559973e9d2a2f5152c7586c72a7d1137e2d8616bfe8" => :sierra
  end

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "gsl" => :linked
  depends_on "pcre" => :linked
  depends_on "gmp" => :linked
  depends_on "z3" => :linked

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
