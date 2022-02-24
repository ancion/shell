#!/bin/bash

:<<!
------------------------------------------------------------------
查看网卡的实时流量
-------------------

!

NIC=$1
echo "  IN ----- OUT "
# 循环输出网络的流量
while true; do 
  OLD_IN=$(awk '$0~"'$NIC'"{print $2}' /proc/net/dev)
  OLD_OUT=$(awk '$0~"'$NIC'"{print $10}' /proc/net/dev)
  sleep 1
  NEW_IN=$(awk '$0~"'$NIC'"{print $2}' /proc/net/dev)
  NEW_OUT=$(awk '$0~"'$NIC'"{print $10}' /proc/net/dev)
  IN=$(printf "%.1f%s" "$((($NEW_IN-$OLD_IN)/1024))" "KB/s")
  OUT=$(printf "%.1f%s" "$((($NEW_OUT-$OLD_OUT)/1024))" "KB/s")
  echo "$IN  $OUT"
  sleep 1
done


