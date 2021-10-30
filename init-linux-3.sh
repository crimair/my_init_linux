#!/bin/bash

read -sp "Password: " pass

unzip -P ${pass} tools.zip
unzip -P ${pass} emacsd.zip
unzip -P ${pass} spacemacs.zip
