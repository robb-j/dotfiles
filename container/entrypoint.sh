#!/usr/bin/env sh

set -e

# TODO: TBR - Ensure the correct permission on mounted ssh files
chown -R user:user /home/user/.ssh

# TODO: TBR
if [ -f "/home/user/.ssh/authorized_keys" ]
then
  chmod 700 /home/user/.ssh/authorized_keys
fi

if [ ! -d "/var/run/sshd" ]
then
  mkdir -p /var/run/sshd
fi

# 
# generate authorized_keys from an environment variable 
# 
if [ -x "$AUTHORIZED_KEYS" ]
then
  echo "AUTHORIZED_KEYS not set, exiting"
  exit 1
fi

if [ -n "$SSH_RSA_PRIVATE_KEY" ]
then
  echo "Setting rsa private key"
  echo "$SSH_RSA_PRIVATE_KEY" > /etc/ssh/ssh_host_rsa_key
fi

echo "$AUTHORIZED_KEYS" > /home/user/.ssh/authorized_keys

echo "Running $@"
exec $@