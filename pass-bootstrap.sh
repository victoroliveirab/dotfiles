#!/bin/bash

git clone $1 $HOME/.password-store
echo "Done. Remember to fetch public and private gpg key in order to use pass."
