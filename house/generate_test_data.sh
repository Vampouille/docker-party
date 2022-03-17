#!/bin/bash

echo "Toto Titi" > /var/run/eb00c318-9fc8-11ec-b589-5fad6eb2c72d.txt
nc -lkU /var/run/eb00c318-9fc8-11ec-b589-5fad6eb2c72d.sock &
echo "Grand Jojo" > /var/run/c9004576-9fc9-11ec-bac8-07f500180f0a.txt
nc -lkU /var/run/c9004576-9fc9-11ec-bac8-07f500180f0a.sock &
