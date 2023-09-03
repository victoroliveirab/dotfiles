echo "Enter the password for the private key:"
gpg --import $1/private.pgp
gpg --import $1/public.pgp
