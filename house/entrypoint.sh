#!/bin/bash

# Generate host keys
ssh-keygen -A

# Setup authorized_keys
mkdir -p /root/.ssh
chmod go-rx /root/.ssh

echo 'command = "/bin/true"' > /root/.ssh/authorized_keys
echo "${PUBLIC_SSH_KEY}" >> /root/.ssh/authorized_keys
chmod go-rx /root/.ssh/authorized_keys

/usr/sbin/sshd -De -o "StreamLocalBindUnlink yes"
