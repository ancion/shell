#!/usr/bin/env bash

work() {
  time=0
  while true
  do 
    echo "hello"
    ((time++))
    if [ $time -gt 3 ]; then 
      echo $time
      time=0
    fi
    sleep 1
  done

}

while IFS= read -r line; do
  [[ $line == \#* || -z $line ]] && continue
  echo "$line"
done < /etc/hosts;
