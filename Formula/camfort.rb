require "language/haskell"

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  VERSION = "0.902".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "http://www.cl.cam.ac.uk/research/dtg/naps/"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "3814436c2333c8be20789386c3fb18bd051fd845c8d6beadbbfd3fdf3ea9535d"

  head "https://github.com/camfort/camfort.git"

  bottle do
    root_url "https://github.com/camfort/camfort/releases/download/v#{VERSION}"
    cellar :any
    sha256 "593c11b580dbd8cfc1e1ddaaa582434afdb58760d813619bddcd27bdbe91d6b8" => :sierra
    sha256 "5cf849671005183a10091de38f551b54056ebe5957c5ff6dedc177a48a3d7bb5" => :el_capitan
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
