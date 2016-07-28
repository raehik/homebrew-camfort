require "language/haskell"

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  VERSION = "0.804".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "http://www.cl.cam.ac.uk/research/dtg/naps/"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "45a0d5df36e9cd948b37eb8bdf51cbe8e9b414b09a402214fc4873c4f77f3b2d"

  head "https://github.com/camfort/camfort.git"

  bottle do
    root_url "https://github.com/camfort/camfort/releases/download/v#{VERSION}"
    cellar :any
    # sha256 "c56debec8f1d5514d18d8c216f8197f90d06ee887fbb95f8234c1894f8a6bf90" => :yosemite
    sha256 "c83bc0b922b294ad4bd375b1dc8ca8b47b55ab4966289ebc0427076106fa1bd4" => :el_capitan
  end

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "gsl" => :linked
  depends_on "pcre" => :linked
  depends_on "gmp" => :linked

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
