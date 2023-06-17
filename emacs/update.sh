#!/bin/bash

read -sp "Password: " pass

echo ${pass} | sudo -S update-alternatives --install /usr/bin/emacs emacs /usr/local/bin/emacs-28.1 2
echo ${pass} | sudo -S update-alternatives --config emacs
