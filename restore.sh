#!/bin/bash

read -sp "Password: " pass

function encrypt () {
    openssl aes-256-cbc -e -pbkdf2 \
            -in <(echo $1) \
            -pass pass:$pass  \
        | base64 -w 0
}

function decrypt () {
    openssl aes-256-cbc -d  -pbkdf2 \
            -in <(echo $1 | base64 -d) \
            -pass pass:$pass
}


echo ""
items=(
)
for item in "${items[@]}" ; do
    url=`encrypt $item`
    echo $url
done

items=(
    "U2FsdGVkX1+tUecqeq92C+zymc1ex4Hv41yXyVm/VQAM6KJmUfzuVF9rpGKbZBqA8WCltFRBAtoAPbqFzulvZiWdRu/94qbLVXz1+wwcbMS9THRNf7rgnmZFsF+2k4I1"
    "U2FsdGVkX18ocgDCG43SJR1m1lx4SpZ/+PtkGILA+z2WiE2iGcRbe0srEe7Wn/8Ww9rhTX97uhf838Hbmaav9y84hx7QNmNBipeZ+TjC/0rb/Nkp9M+o33m/83z2WHm3"
    "U2FsdGVkX18CfQCLSPG1VCLIMuZxsO32PTwFnzWdDyTV+sBI1RLIsyUldi9xliUy8himQDFpRJCITc46uSp3fbYscUZMY2/7seelkkaLC+AJB5RpgLQ+rBOOwEJmdlSi"
)
for item in "${items[@]}" ; do
    url=`decrypt $item`
    curl gdrive.sh | bash -s $url
done
