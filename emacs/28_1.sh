#!/bin/bash

read -sp "Password: " pass

## install depends
echo ${pass} | sudo -S apt-get install -y libgtk-3-dev
echo ${pass} | sudo -S apt-get install -y libwebkit2gtk-4.0-dev
echo ${pass} | sudo -S apt-get install -y libxpm-dev libjpeg-dev libgif-dev libtiff-dev
echo ${pass} | sudo -S apt-get install -y libgnutls28-dev
echo ${pass} | sudo -S apt-get install -y libjansson4 libjansson-dev
echo ${pass} | sudo -S apt-get install -y libgccjit-10-dev
#
if [ ! -e emacs-28.1.tar.gz ]; then
    curl -O http://ftp.gnu.org/gnu/emacs/emacs-28.1.tar.gz
fi
if [ ! -d emacs-28.1 ]; then
    tar xvf emacs-28.1.tar.gz
fi

cd emacs-28.1
cd src
ln -s /usr/lib/gcc/x86_64-linux-gnu/10/include/libgccjit* .
cd ..

CC="clang" CFLAGS="-O2 -march=native -I./src" LDFLAGS="-O2" \
  ./configure \
  --with-xwidgets \
  --with-native-compilation \
  --with-json
make -j8
echo ${pass} | sudo -S make install
