#!/bin/bash
  
:<<!
-----------------------------------------------------------------
监控一系列的服务器磁盘空间，设置磁盘使用的阈值，超过阈值时发送邮件
给管理员，通知进行系统清理
--------------------------
服务器配置了 ssh 私钥登录, 无需输入密码登录

!

# 定义了需要监控的服务器列表，格式
#  192.168.0.122  username port 
HOST_INFO=../temp/host.info

for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO); do
  USER=$(awk -v ip=$IP 'ip==$1{print $2}' $HOST_INFO)
  PORT=$(awk -v ip=$IP 'ip==$1{print $3}' $HOST_INFO)
  # 将远程服务器上的磁盘信息通过 ssh 发送命令并返回内容
  # 记录到本地文件中
  TMP_FILE=/tmp/disk.tmp
  ssh -p $PORT $USER@$IP 'df -h' > $TMP_FILE
  # 将磁盘的分区的利用率转变成 monutpath=userate 形式
  USE_RATE_LIST=$(awk 'BEGIN{OFS="="}/^\/dev/{print $NF,int($5)}' $TMP_FILE)
  for USE_RATE in $USE_RATE_LIST; do
    # 将等号右边包括等号一起去除
    PART_NAME=${USE_RATE%=*}
    # 将等号左边包括等号一起去除
    USE_RATE=${USE_RATE#*=}
    if [ $USE_RATE -ge 80 ]; then 
      # 此处应该时发送邮件到管理员账号，用 echo 临时查看效果
      echo -e "$IP \n Warning: $PART_NAME Partition usage: $USE_RATE"
    else
      echo "YES"
    fi
  done
done

