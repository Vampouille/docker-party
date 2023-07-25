#!/bin/bash

uuid=$(uuid)
read -p 'Name? '
name=$REPLY

echo $name > /tmp/$uuid.txt

scp -i /id_rsa -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' -P ${HOUSE_PORT} /tmp/$uuid.txt ${HOUSE_USER}@${HOUSE_HOST}:/var/run/

autossh -M 0 -N -o 'ServerAliveInterval 45' -o 'ServerAliveCountMax 2' -o 'StrictHostKeyChecking=no' -o 'UserKnownHostsFile=/dev/null' si /id_rsa -R /var/run/docker.sock:/var/run/$uuid.sock -p ${HOUSE_PORT} ${HOUSE_USER}@${HOUSE_HOST}
