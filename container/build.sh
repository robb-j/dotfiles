#/usr/bin/env sh

set -ex

docker build -t test container

KEYS=$(cat ssh2.pub)
SSH=$(cat ssh)

docker run -it --rm -p 30022:22 -e "SSH_RSA_PRIVATE_KEY=$SSH" -e "AUTHORIZED_KEYS=$KEYS" test