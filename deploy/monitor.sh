#!/usr/bin/env bash

function cpu() {
  ratio=$(top -b -n1 | fgrep 'Cpu' | awk '{printf "%.0d", 100-$8}')
  wait=$(free -m | fgrep 'Mem' | awk '{printf "%d", ($3)/$2*100')
  echo "CPU: - 使用率: ${ratio}%, 等待磁盘IO响应使用率: ${wait}%"

  if [ $ratio -gt 80 ];then 
     fileName=(`date +'%F-%H%M%S'`)
     jps -l | grep "equipment" | awk  '{print $1}' | xargs -b -H -n1 -p | grep 'top - ' -A 15  > ${filename}.pid
     jps -l | grep "equipment" | awk  '{print $1}' | xargs jmap -histo > ${fileName}.hepdump
     jps -l | grep "equipment" | awk  '{print $1}' | xargs jstack > ${fileName}.stac
  fi
}
while(true)
do
  sleep 10
  cpu 
done
