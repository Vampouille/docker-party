#!/bin/bash

uuid=$(uuid)
read -p 'Name? '
name=$REPLY

echo $name > /tmp/$uuid.txt

scp -i /id_rsa /tmp/$uuid.txt $*:/var/run/

autossh -M 0 -N -o 'ServerAliveInterval 45' -o 'ServerAliveCountMax 2' -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -i /id_rsa -R /var/run/docker.sock:/var/run/$uuid.sock $*
