#!/bin/bash

read -sp "Password: " pass

isWSL=false
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    isWSL=true
    echo "WSL"
fi


echo ${pass} | sudo -S apt-get update
echo ${pass} | sudo -S apt-get -y upgrade
# wsl gnome

if $isWSL ; then
    echo ${pass} | sudo -S apt-mark hold acpid acpi-support
    echo ${pass} | sudo -S apt-get install -y ubuntu-desktop-minimal

    echo "export GNOME_SHELL_SESSION_MODE=ubuntu"  >> ~/.xsessionrc
    echo "export XDG_CURRENT_DESKTOP=ubuntu:GNOME" >> ~/.xsessionrc
    echo "export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop" >> ~/.xsessionrc
    echo "export WAYLAND_DISPLAY=" >> ~/.xsessionrc
    echo "export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg" >> ~/.xsessionrc

    echo ${pass} | sudo -S apt-get install -y xrdp
    echo ${pass} | sudo -S sed -i 's/port=3389/port=13389/' /etc/xrdp/xrdp.ini
fi

exit
