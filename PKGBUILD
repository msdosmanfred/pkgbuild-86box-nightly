# Maintainer: Alexander Höfer <hoefer9 at gmail dot com>
pkgname=86box-nightly
_pkgname=86Box
pkgver=9277
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
sha512sums=('33cd9efdfd1e6ace716f6a3b278929209daf3893aae746ab28eb7b8e5d8f20a3e9b49440be28134776e0c39b128175aeac4d574d17488d331f587668373a4f7b'
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
