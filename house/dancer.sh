#!/bin/bash

if [ $# -gt 1 ]; then
  echo "Invalid usage"
  echo "Usage:"
  echo "  * List dancer with: $0"
  echo "  * Select dancer with: $0 <dancer UUID>"
  exit 1
fi

if [ -L "/var/run/docker.sock" ]; then
  current_dancer_socket=$(readlink -f /var/run/docker.sock)
  current_dancer_uuid=$(basename ${current_dancer_socket} .sock)
  current_dancer_name=$(cat /var/run/${current_dancer_uuid}.txt)
fi

if [ $# -eq 0 ]; then
  dancers_files=$(ls /var/run/*.txt 2> /dev/null || true)
  if [ -n "${dancers_files}" ]; then
    for dancer_desc_file in $(ls /var/run/*.txt 2> /dev/null || true); do
      dancer_name=$(cat ${dancer_desc_file})
      dancer_uuid=$(basename ${dancer_desc_file} .txt)
      if [ $dancer_uuid = "$current_dancer_uuid" ]; then
        echo -n "$(tput bold)"
      fi
      echo -n "${dancer_uuid} ${dancer_name}"
      if [ $dancer_uuid = "$current_dancer_uuid" ]; then
        echo " *💃*$(tput sgr0)"
      else
        echo ""
      fi
    done
  else
    echo "🏠 The dancerfloor is empty 🧶"
  fi

elif [ $1 = "completion" ]; then

  echo -n "("
  for dancer_desc_file in $(ls /var/run/*.txt 2> /dev/null || true); do
    dancer_name=$(cat ${dancer_desc_file})
    dancer_uuid=$(basename ${dancer_desc_file} .txt)
    echo -n "${dancer_uuid}:'${dancer_name}"
    if [ $dancer_uuid = "$current_dancer_uuid" ]; then
      echo -n " *💃*"
    fi
    echo -n "' "
  done
  echo ")"

else

  dancer_uuid=$1
  if [ ! -S "/var/run/${dancer_uuid}.sock" ]; then
    echo "No such dancer: ${dancer_uuid}"
    echo "No docker socket found at '/var/run/${dancer_uuid}.sock'"
    exit 3
  fi
  if [ -L /var/run/docker.sock ]; then
    rm /var/run/docker.sock
  fi
  ln -s /var/run/${dancer_uuid}.sock /var/run/docker.sock

fi
