#!/usr/bin/env sh

set -e

# TODO: TBR - Ensure the correct permission on mounted ssh files
# chown -R user:user /home/user/.ssh

# TODO: TBR
# if [ -f "/home/user/.ssh/authorized_keys" ]
# then
#   chmod 700 /home/user/.ssh/authorized_keys
# fi

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
fi

echo "Installing oh-my-zsh"
sudo -u user \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Running $@"
exec $@