#!/bin/bash

read -sp "Password: " pass

isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
    echo "WSL"
fi

echo "Emacs*useXIM: false" > .Xresources

echo ${pass} | sudo -S apt-get update
#echo ${pass} | sudo -S add-apt-repository -y ppa:kelleyk/emacs
echo ${pass} | sudo -S apt-get -y upgrade
echo ${pass} | sudo -S apt-get install -y git build-essential openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev liblzma-dev
echo ${pass} | sudo -S apt-get install -y flex bison libelf-dev libncurses-dev autoconf libudev-dev libtool
echo ${pass} | sudo -S apt-get install -y x11-apps net-tools
echo ${pass} | sudo -S apt-get install -y vim-gtk3
echo ${pass} | sudo -S apt-get install -y emacs emacs-mozc
if $isWSL then
    echo ${pass} | sudo -S apt-get install -y fcitx-mozc dbus-x11
    echo ${pass} | sudo -S sh -c "dbus-uuidgen > /var/lib/dbus/machine-id"
fi
# llvm
echo ${pass} | sudo -S apt-get install -y python python3 zip zlib1g-dev xz-utils wget curl
echo ${pass} | sudo -S apt-get install -y clang-12 clangd-12 lld-12 llvm-12
echo ${pass} | sudo -S apt-get install -y cmake
echo ${pass} | sudo -S apt-get install -y ninja-build
echo ${pass} | sudo -S update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 100
echo ${pass} | sudo -S update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 100
echo ${pass} | sudo -S update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
echo ${pass} | sudo -S update-alternatives --install /usr/bin/cc cc /usr/bin/clang-12 100
echo ${pass} | sudo -S update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-12 100
echo ${pass} | sudo -S update-alternatives --install /usr/bin/lld lld /usr/bin/lld-12 100
# tools
echo ${pass} | sudo -S apt-get install -y silversearcher-ag
echo ${pass} | sudo -S snap install drawio
echo ${pass} | sudo -S apt-get install -y gtkterm
echo ${pass} | sudo -S apt-get install -y verilator gtkwave
echo ${pass} | sudo -S apt-get install -y global
# nodejs
echo ${pass} | sudo -S apt-get install -y nodejs npm
echo ${pass} | sudo -S npm install -g n
echo ${pass} | sudo -S n stable
echo ${pass} | sudo -S npm install -g vmd
echo ${pass} | sudo -S apt-get purge -y nodejs npm
# docker
echo ${pass} | sudo -S apt-get remove -y docker docker-engine docker.io containerd runc
echo ${pass} | sudo -S apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo ${pass} | sudo -S add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# docker install
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# docker-compose install
echo ${pass} | sudo -S curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo ${pass} | sudo -S chmod +x /usr/local/bin/docker-compose
# docker env
echo ${pass} | sudo -S groupadd docker
echo ${pass} | sudo -S gpasswd -a $USER docker
# chrome
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y google-chrome-stable
# gnome
echo ${pass} | sudo -S apt-add-repository universe
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y gnome-tweak-tool
# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian focal contrib"
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y virtualbox-6.1
# etc
echo ${pass} | sudo -S gpasswd -a $USER dialout

exit

