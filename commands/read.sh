#!/usr/bash

while IFS= read -r line; do
  [[ $line == \#* || -z $line ]] && continue
  echo "$line"
done < /etc/hosts;
