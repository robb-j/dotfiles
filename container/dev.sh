#/usr/bin/env sh

set -e

docker rmi dotfiles || true

docker build -t dotfiles container

SERVER_KEY=$(cat container/server_key)
AUTHORIZED_KEYS=$(cat container/authorized_keys)
KUBECONFIG=$(cat ~/.kube/config)

docker run -it \
  --rm \
  -p 30022:22 \
  -e "SSH_RSA_PRIVATE_KEY=$SERVER_KEY" \
  -e "AUTHORIZED_KEYS=$AUTHORIZED_KEYS" \
  -e "KUBECONFIG=$KUBECONFIG" \
  -e "DOTFILES_REMOTE=https://github.com/robb-j/dotfiles.git" \
  dotfiles
