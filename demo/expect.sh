#!/bin/bash

:<<!
-------------------------------------------------------------------
同时与多台远程服务器发送命令进行操作，当遇到需要交互的场景的的时候，
需要借助expect, 将命令交给expect, 按照一定的预期结果来执行对应的交互
过程
-------------------------
1. 可以在脚本中嵌入一段 expect 命令
2. 可以将需要交互的脚本完整过程放在一个文件中，并在文件首行中指定
   执行命令的 expect 解释器，这样可以直接运行脚本文件完成交互过程
!

COMMAND=$*

# 定义需要进行执行命令的主机列表
# 列表格式
# 192.168.1.445 username  port  password 

HOST_INFO=../temp/host.list
for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO); do
  USER=$(awk -v ip=$IP 'ip==$1{print $2}' /$HOST_INFO)
  PORT=$(awk -v ip=$IP 'ip==$1{print $3}' /$HOST_INFO)
  PASS=$(awk -v ip=$IP 'ip==$1{print $4}' /$HOST_INFO)
  # 使用 expect 建立连接并发送命令来执行
  expect -c "
    spawn ssh -p $PORT $USER@$IP
    expect {
      \"(yes/no)\" {send \"yes\r\"; exp_continue}
      \"password:\" {send \"$PASS\r\"; exp_continue}
      \"$USER@*\" {send \"$COMMAND\r exit\r\"; exp_continue}
    }
  "
  echo "--------------------------"
done

