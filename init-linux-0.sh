#!/bin/bash

read -sp "Password: " pass

isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
    echo "WSL"
fi

if ! $isWSL ; then
    echo ${pass} | sudo -S apt-get install libxcb-cursor0
    #deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian <mydist> contrib
    #sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" >> /etc/apt/sources.list
    #sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor oracle_vbox_2016.asc
    curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
    echo ${pass} | sudo -S apt-get update
    echo ${pass} | sudo -S apt-get install -y virtualbox-7.1
    echo ${pass} | sudo -S gpasswd -a $USER vboxusers
fi
exit

echo "Emacs*useXIM: false" > ~/.Xresources

echo ${pass} | sudo -S apt-get update
#echo ${pass} | sudo -S add-apt-repository -y ppa:kelleyk/emacs
echo ${pass} | sudo -S apt-get -y upgrade
echo ${pass} | sudo -S apt-get install -y git build-essential openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libffi-dev liblzma-dev
echo ${pass} | sudo -S apt-get install -y flex bison libelf-dev libncurses-dev libncurses5-dev autoconf libudev-dev libtool
echo ${pass} | sudo -S apt-get install -y x11-apps net-tools
echo ${pass} | sudo -S apt-get install -y language-pack-ja
echo ${pass} | sudo -S apt-get install -y vim-gtk3
echo ${pass} | sudo -S apt-get install -y emacs emacs-mozc

# llvm
echo ${pass} | sudo -S apt-get install -y python3 python3-pip zip zlib1g-dev xz-utils wget curl
echo ${pass} | sudo -S apt-get install -y cmake
echo ${pass} | sudo -S apt-get install -y ninja-build
## llvm
echo ${pass} | sudo -S apt-get install -y clang clangd lld llvm lldb
echo ${pass} | sudo -S apt-get install -y clang-format
# tools
echo ${pass} | sudo -S apt-get install -y silversearcher-ag
echo ${pass} | sudo -S apt-get install -y ripgrep
echo ${pass} | sudo -S snap install drawio
echo ${pass} | sudo -S apt-get install -y gtkterm
echo ${pass} | sudo -S apt-get install -y verilator gtkwave
echo ${pass} | sudo -S apt-get install -y global
echo ${pass} | sudo -S apt-get install -y bear dos2unix unix2dos
# nodejs
echo ${pass} | sudo -S apt-get install -y nodejs npm
echo ${pass} | sudo -S npm install -g n
echo ${pass} | sudo -S n stable
echo ${pass} | sudo -S apt-get purge -y nodejs npm
echo ${pass} | sudo -S npm install -g vmd
## docker
#echo ${pass} | sudo -S apt-get remove -y docker docker-engine docker.io containerd runc
#echo ${pass} | sudo -S apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#echo ${pass} | sudo -S add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
## docker install
#echo ${pass} | sudo -S apt-get update
#echo ${pass} | sudo -S sudo apt-get install -y docker-ce docker-ce-cli containerd.io
## docker-compose install
#echo ${pass} | sudo -S curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#echo ${pass} | sudo -S chmod +x /usr/local/bin/docker-compose
## docker env
#echo ${pass} | sudo -S groupadd docker
#echo ${pass} | sudo -S gpasswd -a $USER docker
# chrome
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y google-chrome-stable
# virtualbox
if ! $isWSL ; then
    echo ${pass} | sudo -S apt-get install libxcb-cursor0
    #deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian <mydist> contrib
    deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib
    sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor oracle_vbox_2016.asc
    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
    echo ${pass} | sudo -S apt-get update
    echo ${pass} | sudo -S apt-get install -y virtualbox-7.1
    echo ${pass} | sudo -S gpasswd -a $USER vboxusers
fi
# etc
echo ${pass} | sudo -S gpasswd -a $USER dialout

## ctrl nocaps
echo ${pass} | sudo -S sed -i s/XKBO.*/XKBOPTIONS=\"ctrl:nocaps\"/ /etc/default/keyboard
echo ${pass} | sudo -S sed -i s/XKBMODEL.*/XKBMODEL=\"pc106\"/ /etc/default/keyboard

## vscode
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
echo ${pass} | sudo -S apt-get install -y apt-transport-https
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y code

# application
## nemo
echo ${pass} | sudo -S apt-get install -y nemo

## etc
echo ${pass} | sudo -S apt-get install -y libhdf5-dev
echo ${pass} | sudo -S apt-get install -y librsvg2-dev
echo ${pass} | sudo -S apt-get install -y libvterm
echo ${pass} | sudo -S apt-get install -y libtool-bin

# fcitx5
echo ${pass} | sudo -S apt-get update
# 言語選択ツールと依存関係をインストール
echo ${pass} | sudo -S apt-get -y install language-selector-common
# 推奨される日本語関連パッケージをインストール
echo ${pass} | sudo -S apt-get -y install $(check-language-support)
# パッケージリストを再度更新 (念のため)
echo ${pass} | sudo -S apt-get update
# Fcitx5本体、Mozcエンジン、設定ツールをインストール
echo ${pass} | sudo -S apt-get -y install fcitx5 fcitx5-mozc fcitx5-config-qt
# 次回のログインセッションから Fcitx5 を使用するように設定
im-config -n fcitx5
# 自動起動対策
cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config//autostart/

# gnome
if ! $isWSL ; then
    echo ${pass} | sudo -S apt-add-repository universe
    echo ${pass} | sudo -S apt-get update
    echo ${pass} | sudo -S apt-get install -y gnome-tweaks
    echo ${pass} | sudo -S apt-get install -y gnome-shell-extension-manager
    pip install --user gnome-extensions-cli
    gnome-extensions-cli install dash-to-panel@jderose9.github.com
    gnome-extensions-cli install drive-menu@gnome-shell-extensions.gcampax.github.com
    gnome-extensions-cli install kimpanel@kde.org
    gnome-extensions-cli install sound-output-device-chooser@kgshank.net
    gnome-extensions-cli install tilingshell@ferrarodomenico.com
    gnome-extensions-cli install tophat@fflewddur.github.io
fi

# wsl gnome

if $isWSL ; then
    echo ${pass} | sudo -S apt-mark hold acpid acpi-support
    echo ${pass} | sudo -S apt-get install -y xubuntu-desktop

    echo "export DESKTOP_SESSION=xubuntu" > ~/.xsessionrc
    echo "export XDG_CURRENT_DESKTOP=XFCE" >> ~/.xsessionrc
    echo "export XDG_DATA_DIRS=/usr/share/xubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop" >> ~/.xsessionrc
    echo "export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg" >> ~/.xsessionrc


    echo ${pass} | sudo -S apt-get install -y xrdp
    echo ${pass} | sudo -S sed -i 's/port=3389/port=13389/' /etc/xrdp/xrdp.ini
    ##sudo service xrdp restart

    #echo ${pass} | sudo -S apt-add-repository universe
    #echo ${pass} | sudo -S apt-get update
    #echo ${pass} | sudo -S apt-get install -y gnome-tweaks
    #echo ${pass} | sudo -S apt-get install -y gnome-shell-extension-manager
    #pip install --user gnome-extensions-cli
    #gnome-extensions-cli install dash-to-panel@jderose9.github.com
    #gnome-extensions-cli install drive-menu@gnome-shell-extensions.gcampax.github.com
    #gnome-extensions-cli install kimpanel@kde.org
    #gnome-extensions-cli install sound-output-device-chooser@kgshank.net
    #gnome-extensions-cli install tilingshell@ferrarodomenico.com
    #gnome-extensions-cli install tophat@fflewddur.github.io
fi

exit
