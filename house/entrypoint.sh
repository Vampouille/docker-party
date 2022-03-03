#!/bin/bash

# Verify configuration
if [ -z "$HOUSE_PORT" ]; then
  echo '$HOUSE_PORT is not defined'
  exit 1
fi
if [ -z "$HOUSE_USER" ]; then
  echo '$HOUSE_USER is not defined'
  exit 2
fi
if [ -z "$HOUSE_PORT" ]; then
  echo '$HOUSE_PORT is not defined'
  exit 3
fi

# Generate host keys
ssh-keygen -A

# Generate dancer key pair
ssh-keygen -b 4096 -N '' -f /tmp/id_rsa

# Setup authorized_keys
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
chmod go-rx /root/.ssh
chmod go-rx /root/.ssh/authorized_keys

echo 'command = "/bin/true"' > /root/.ssh/authorized_keys
cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys

# Generate invitation
export PRIVATE_KEY=$(cat /tmp/id_rsa)

cat /invitation.template | envsubst '$HOUSE_USER:$HOUSE_HOST:$HOUSE_PORT:$PRIVATE_KEY' > /tmp/dancer.sh
chmod +x /tmp/dancer.sh

/usr/sbin/sshd -De -o "StreamLocalBindUnlink yes"
