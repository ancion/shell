#!/usr/bin/env bash

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
