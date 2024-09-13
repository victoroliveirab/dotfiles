#!/bin/bash

if [ -d "$1/shared" ]; then
  echo "Enter the password for the private key of the shared password store:"
  gpg --import $1/shared/private.pgp
  gpg --import $1/shared/public.pgp
fi

if [ -d "$1/personal" ]; then
  echo "Enter the password for the private key of the personal password store:"
  gpg --import $1/personal/private.pgp
  gpg --import $1/personal/public.pgp
fi

if [ -d "$1/work" ]; then
  echo "Enter the password for the private key of the work password store:"
  gpg --import $1/work/private.pgp
  gpg --import $1/work/public.pgp
fi
