require "language/haskell"

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  VERSION = "0.900".freeze

  desc "Refactoring and verification tool for Fortran"
  homepage "http://www.cl.cam.ac.uk/research/dtg/naps/"
  url "https://hackage.haskell.org/package/camfort-#{VERSION}/camfort-#{VERSION}.tar.gz"
  sha256 "fc92d5a5d5ecf42470d4f7aea2848eb785e44ba925949df86599e7b96f4a4427"

  head "https://github.com/camfort/camfort.git"

  bottle do
    root_url "https://github.com/camfort/camfort/releases/download/v#{VERSION}"
    cellar :any
    sha256 "1c10b499fb28caea271277f54b89e70e6b28cb7bddfeaa3482e6c90e92294faf" => :yosemite
    sha256 "12e492a28117d8f4069e95a30eaa286655b9e66561afe33d8274a0c498e6f4f0" => :el_capitan
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
