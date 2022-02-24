#!/bin/bash

:<<!
-----------------------------------------------------------------------------
查看服务器的资源状态
----------------------
1. CPU 
2. MEM
3. Disk
4. TCP 连接状态
----------------------
!


# cpu 的使用情况
function cpu() {
  util=$(vmstat | awk '{if (NR==3) print $13+$14}')
  wait=$(vmstat | awk '{if (NR==3) print $16}')
  echo "CPU: - 使用率: ${util}%, 等待磁盘IO响应使用率: ${wait}%"
}

# 内存的使用情况
function memory(){
  total=$(free -m | awk '{if (NR==2)printf "%.1f", $2/1024}')
  hused=$(free -m | awk '{if (NR==2)printf "%.1f", ($2-$NF)/1024}')
  avail=$(free -m | awk '{if (NR==2)printf "%.1f", $NF/1024}')
  echo "MEM: - 总大小: ${total}G, 已使用: ${hused}G, 剩余: ${avail}G"
}

# 磁盘的使用情况
function disk() {
  fs=$(df -h | awk '/^\/dev/{print $1}')
  for p in $fs; do
    mount=$(df -h | awk -v p=$p '$1==p{print $NF}')
    tsize=$(df -h | awk -v p=$p '$1==p{print $2}' )
    hused=$(df -h | awk -v p=$p '$1==p{print $3}' )
    pused=$(df -h | awk -v p=$p '$1==p{print $5}' )
    echo "DSK: - 挂载点: $mount, 总大小: $tsize, 已使用: $hused, 使用率: $pused"
  done
}

# 监测 TCP 连接状态, netstat 命令使用需要安装 net-tools 工具包
function tcps(){
  
  summary=$(netstat -antp | awk '{arr[$6]++}END{for (i in arr) printf i":"arr[i]" "}')
  echo "TCP: - $summary"
  
}

cpu
memory
disk
tcps
