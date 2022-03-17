#!/bin/bash

if [ "$1" != "list" ] && [ "$1" != "use" ] && [ "$1" != "completion" ]; then
  echo "Invalid or no command : $1"
  echo "Usage $0 use|list"
  exit 1
fi

if [ $1 = "list" ]; then
  for dancer_desc_file in $(ls /var/run/*.txt); do
    dancer_name=$(cat ${dancer_desc_file})
    dancer_uuid=$(basename ${dancer_desc_file} .txt)
    echo "${dancer_uuid} ${dancer_name}"
  done
elif [ $1 = "completion" ]; then
  echo -n "("
  #echo "(ITEM1:'DESC1' ITEM2:'DESC2')"
  #exit 0
  for dancer_desc_file in $(ls /var/run/*.txt); do
    dancer_name=$(cat ${dancer_desc_file})
    dancer_uuid=$(basename ${dancer_desc_file} .txt)
    echo -n "${dancer_uuid}:'${dancer_name}' "
  done
  echo ")"

elif [ $1 = "use" ]; then
  dancer_uuid=$2
  if [ -z "$2" ]; then
    echo "No dancer specified"
    echo "Usage: $0 use <dancer UUID>"
    echo "See '$0 list' for a list of dancers"
    exit 2
  fi
  if [ ! -S "/var/run/$2.sock" ]; then
    echo "No such dancer: $2"
    echo "No docker socket found at '/var/run/$2.sock'"
    exit 3
  fi
  if [ -L /var/run/docker.sock ]; then
    rm /var/run/docker.sock
  fi
  ln -s /var/run/$2.sock /var/run/docker.sock
elif [ $1 = "get" ]; then
  dancer_socket=$(readlink -f /var/run/docker.sock)
  dancer_uuid=$(basename ${dancer_socket} .sock)
  dancer_name=$(cat /var/run/${dancer_uuid}.txt)
else
  echo "Invalid command"
  exit 4
fi
