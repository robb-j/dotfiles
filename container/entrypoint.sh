#!/usr/bin/env sh

set -e


# TODO: is this needed?
if [ ! -d "/var/run/sshd" ]
then
  mkdir -p /var/run/sshd
fi

# 
# generate authorized_keys from an environment variable 
# 
if [ -n "$AUTHORIZED_KEYS" ]
then
  echo "Setting authorized keys"
  echo "$AUTHORIZED_KEYS" > /home/user/.ssh/authorized_keys
fi

if [ -n "$SSH_RSA_PRIVATE_KEY" ]
then
  echo "Setting rsa private key"
  echo "$SSH_RSA_PRIVATE_KEY" > /etc/ssh/ssh_host_rsa_key
fi

if [ -n "$DOTFILES_REMOTE" ]
then
  echo "Downloading dotfiles"
  echo "$DOTFILES_REMOTE"
  sudo -u user git clone $DOTFILES_REMOTE dotfiles
  
  # echo "Brew install"
  # brew bundle install --file $DOTFILES_REMOTE/Brewfile --cleanup
fi

if [ -n "$KUBECONFIG" ]
then
  echo "Setting up .kube/config"
  mkdir -p /home/user/.kube
  echo "$KUBECONFIG" > /home/user/.kube/config
  chown -R user:user /home/user/.kube
fi

echo "Installing oh-my-zsh"
sudo -u user \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Running $@"
exec $@
