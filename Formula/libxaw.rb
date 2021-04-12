class Libxaw < Formula
  desc "X.Org: X Athena Widget Set"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXaw-1.0.14.tar.bz2"
  sha256 "76aef98ea3df92615faec28004b5ce4e5c6855e716fa16de40c32030722a6f8e"
  license "MIT"

  bottle do
    sha256 arm64_big_sur: "0f7f9dc31f8aa0f810ca434cf6bc941ff28d9904ed8cd48c18671584f5d27c04"
    sha256 big_sur:       "c791467b848242806594004d828fc9134f44a6ed8ea8b2ce555fbabaf3373bcb"
    sha256 catalina:      "cdaab6ac0ae83f6c7fd615f00f1ac9d4111d7912b4d4c3f1d6065f7bc3735485"
    sha256 mojave:        "d62b47d62a98b1e98d674ee06861dd7d0a2d52ae177df35e10efc850b94f0147"
    sha256 high_sierra:   "1c6e777ab323b157620636022ac3f19bf83c39fa3ee97768b52c82abaa870281"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxmu"
  depends_on "libxpm"
  depends_on "libxt"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-specs=no
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/Xaw/Text.h"

      int main(int argc, char* argv[]) {
        XawTextScrollMode mode;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
