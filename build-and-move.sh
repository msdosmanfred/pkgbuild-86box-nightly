#!/bin/bash

makepkg -rsc
sudo mv *.pkg.tar.zst /var/repo/local/
rm -rf 86box-nightly*
makepkg --printsrcinfo >.SRCINFO
nightly commit -am "updated PKGBUILD"
nightly push
