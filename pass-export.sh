gpg --output public.pgp --armor --export $1
gpg --output private.pgp --armor --export-secret-key $1
