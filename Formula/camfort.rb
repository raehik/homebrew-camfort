require 'language/haskell'

# Homebrew formula for CamFort
class Camfort < Formula
  include Language::Haskell::Cabal

  desc 'Refactoring and verification tool for Fortran'
  homepage 'http://www.cl.cam.ac.uk/research/dtg/naps/'
  url 'https://hackage.haskell.org/package/camfort-0.802/camfort-0.802.tar.gz'
  sha256 'de057c0bfc71ff291b7a0e5581eaddaceadedc83af00774a329593a11842d6a2'

  head 'https://github.com/camfort/camfort.git'

  depends_on 'ghc' => :build
  depends_on 'cabal-install' => :build
  depends_on 'gsl' => :linked
  depends_on 'pcre' => :linked
  depends_on 'gmp' => :linked

  bottle do
    root_url 'http://www.cl.cam.ac.uk/research/dtg/camfort/bottles'
    cellar :any
    sha256 'ebe2f1cdef6d00c77eca2028013f1f5668ab2e78703ee4308b5050ca4de06b4e' => :el_capitan
  end

  def install
    install_cabal_package using: %w(alex happy)
  end

  test do
    # Test to see if units-suggest runs without errors
    crit_units_test = testpath / 'crit_units_test.f90'
    crit_units_test.write <<-EOF
      program crit_units_test
        integer x, y, z
        x = y * z
      end program crit_units_test
    EOF

    system bin / 'camfort', 'units-suggest', crit_units_test
  end
end
