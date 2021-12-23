#!/bin/bash

read -sp "Password: " pass

zip -r -e --password=${pass} tools.zip ~/tools
zip -r -e --password=${pass} emacsd.zip ~/.emacs.d ~/.fonts
zip -r -e --password=${pass} spacemacs.zip ~/.spacemacs
