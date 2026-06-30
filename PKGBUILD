# Maintainer: Alexander Höfer <hoefer9 at gmail dot com>
pkgname=86box-nightly
_pkgname=86Box
pkgver=9256
pkgrel=1
pkgdesc='An emulator for classic IBM PC clones'
arch=('x86_64' 'aarch64') # use 5.1-2 for pentium4 and armv7h
url='https://86box.net/'
license=('GPL-2.0-or-later' 'CC-BY-4.0')
depends=('fluidsynth' 'hicolor-icon-theme' 'libserialport' 'libslirp' 'openal' 'qt6-base' 'rtmidi' 'sdl2'                                                                    # explicit
  'freetype2' 'gcc-libs' 'glib2' 'glibc' 'libevdev' 'libglvnd' 'libpng' 'libsndfile' 'libx11' 'libxcb' 'libxext' 'libxi' 'libxkbcommon-x11' 'libxkbcommon' 'wayland' 'zlib') # implicit
makedepends=('cmake>=3.21' 'extra-cmake-modules' 'ninja' 'qt6-tools' 'vde2' 'vulkan-headers' 'git')
optdepends=(
  '86box-roms: ROM files'
  'discord-game-sdk: Discord Rich Presence'
  'ghostscript: Printing with Generic PostScript Printer'
  'libpcap: Networking not limited to TCP/IP'
)
provides=('86box')
conflicts=('86box' '86box-git' '86box-odr-git' 'pcbox-git')
options=('!buildflags')
source=(
  "${pkgname}_$pkgver.txz::https://ci.86box.net/job/${_pkgname}/$pkgver/artifact/${_pkgname}-Source-b$pkgver.tar.xz"
  "${pkgname}-assets::git+https://github.com/86Box/assets.git"
)
sha512sums=('bba6c542a0f663aa0c491f7e5f2d698fd07eacc06e807d5536c1b3d9a0de3f68c9164b322d53e26fcc073d78bf6080c00808660fc955054505e39b599e89948a'
            'SKIP')

build() {
  LDFLAGS='-z now -z shstk' cmake -Bbuild --preset regular --toolchain "cmake/flags-gcc-${CARCH}.cmake" -DCMAKE_INSTALL_PREFIX=/usr -DUSE_QT6=on -DNEW_DYNAREC=on -D "BUILD_TYPE=alpha" -D "EMU_BUILD=build ${pkgver}" -D "EMU_BUILD_NUM=$pkgver"
  cmake --build build
}

package() {
  DESTDIR="${pkgdir}" cmake --build "${srcdir}/build" --target install
  for i in 16x16 20x20 24x24 32x32 48x48 64x64 72x72 128x128 256x256; do
    install -Dm644 "$srcdir/src/unix/assets/$i/net.86box.86Box.png" -t "$pkgdir/usr/share/icons/hicolor/$i/apps"
  done
  install -Dm644 "$srcdir/src/unix/assets/net.86box.86Box.desktop" "$pkgdir/usr/share/applications/net.86box.86Box.desktop"
  install -d "$pkgdir/usr/share/86Box/assets"
  cp -a "$srcdir/${pkgname}-assets/sounds" "$pkgdir/usr/share/86Box/assets"
}
