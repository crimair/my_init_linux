#!/bin/bash

read -sp "Password: " pass

isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
    echo "WSL"
fi

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
echo ${pass} | sudo -S apt-add-repository universe
echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get install -y gnome-tweaks
echo ${pass} | sudo -S apt-get install -y gnome-shell-extension-manager python3-pip
pip3 install --break-system-packages --user gnome-extensions-cli
~/.local/bin/gnome-extensions-cli install dash-to-panel@jderose9.github.com
~/.local/bin/gnome-extensions-cli install drive-menu@gnome-shell-extensions.gcampax.github.com
~/.local/bin/gnome-extensions-cli install kimpanel@kde.org
~/.local/bin/gnome-extensions-cli install sound-output-device-chooser@kgshank.net
~/.local/bin/gnome-extensions-cli install tilingshell@ferrarodomenico.com
~/.local/bin/gnome-extensions-cli install tophat@fflewddur.github.io


exit
