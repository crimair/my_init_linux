#!/bin/bash

read -sp "Password: " pass

## install depends
echo ${pass} | sudo -S apt-get install -y libgtk-3-dev
echo ${pass} | sudo -S apt-get install -y libwebkit2gtk-4.0-dev
echo ${pass} | sudo -S apt-get install -y libxpm-dev libjpeg-dev libgif-dev libtiff-dev
### apt-cache search 'libgnutls.*-dev'
echo ${pass} | sudo -S apt-get install -y libgnutls28-dev
echo ${pass} | sudo -S apt-get install -y libjansson4 libjansson-dev
#
if [ ! -e emacs-27.2.tar.gz ]; then
    curl -O http://ftp.gnu.org/gnu/emacs/emacs-27.2.tar.gz
fi
if [ ! -f emacs-27.2 ]; then
    tar xvf emacs-27.2.tar.gz
fi

cd emacs-27.2
#./configure --with-xwidgets
env CC="clang -fobjc-arc" CFLAGS="-O2 -march=native" LDFLAGS="-O2" ./configure --with-xwidgets
make -j8
echo ${pass} | sudo -S make install
