#!/bin/bash

read -sp "Password: " pass

if [ -d rtags ]; then
    rm -rf rtags
fi

git clone --recursive https://github.com/Andersbakken/rtags.git
cd rtags

mkdir build && cd build
cmake -H.. -BRelease -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=/usr/lib/llvm-12 \
      -DLLVM_INCLUDE_DIR=/usr/lib/llvm-12/include \
      -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-12/
cmake --build Release
echo ${pass} | sudo -S cmake --build Release --target install
