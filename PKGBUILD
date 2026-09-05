# Maintainer: Alexander Höfer <hoefer9 at gmail dot com>
pkgname=86box-nightly
_pkgname=86Box
pkgver=9892
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
  'librashader>=0.11.2: Vulkan slang shaders'
  'libretro-shaders-slang: Shaders for OpenGL and Vulkan'
)
provides=('86box')
conflicts=('86box' '86box-git' '86box-odr-git' 'pcbox-git')
options=('!buildflags' '!zipman')
source=(
  "${pkgname}_$pkgver.txz::https://ci.86box.net/job/${_pkgname}/$pkgver/artifact/${_pkgname}-Source-b$pkgver.tar.bz2"
  "${pkgname}-assets::git+https://github.com/86Box/assets.git"
)
sha512sums=('d0d01c8c067e0ff85e21926bdf16cc011a05c14cc1e28839f8c4b1bb5de141364781cc29bc31f3425c60106045ae268a523d2946f686623a424af4d2392f8b84'
  'SKIP')

build() {
  LDFLAGS='-z now -z shstk' cmake -Bbuild --preset regular -DCMAKE_INSTALL_PREFIX=/usr -DQT=on -DNEW_DYNAREC=on -DDEV_BRANCH=on #-D "BUILD_TYPE=alpha" -D "EMU_BUILD=build ${pkgver}" -D "EMU_BUILD_NUM=$pkgver"
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
