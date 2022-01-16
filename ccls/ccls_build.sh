#!/bin/bash

read -sp "Password: " pass

echo ${pass} | sudo -S apt-get install -y libclang-12-dev

if [ -d ccls ]; then
    rm -rf ccls
fi

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls

mkdir build && cd build

cmake -H.. -BRelease -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=/usr/lib/llvm-12 \
      -DLLVM_INCLUDE_DIR=/usr/lib/llvm-12/include \
      -DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-12/

cmake --build Release
echo ${pass} | sudo -S cmake --build Release --target install
