#!/bin/env bash

# run a series of commands on a list of devices over ssh, saving
# the output from each command to a unique file

# single line 
# d=$(date +%Y%m%d-%H%M%S); cat devices.txt | while read dev; do cat commands.txt | while read c; do c2=$(echo ${c} | sed 's/\ /_/g'); (echo; echo; echo "================"; echo "${dev} | ${c}"; echo "================"; echo; echo; read -t 2 </dev/tty; sss -n ${dev} "${c}" 2>&1; echo; echo) | tee ${d}__${dev}__${c2}.txt; done; done
#


d=$(date +%Y%m%d-%H%M%S)

cat devices.txt | while read dev; do 
  cat commands.txt | while read c; do
    c2=$(echo ${c} | sed 's/\ /_/g')
    (
      echo
      echo
      echo "================"
      echo "${dev} | ${c}"
      echo "================"
      echo
      echo
      read -t 2 </dev/tty
      sshpass -e ssh -o ConnectTimeout=3 -n ${dev} "${c}" 2>&1
      echo
      echo
    ) | tee ${d}__${dev}__${c2}.txt
  done
done
