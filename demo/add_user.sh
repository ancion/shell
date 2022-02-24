#!/bin/bash

:<<!
--------------------------------------------------------------------------
批量创建一批用户：
------------------

用户名作为参数，以空格隔开，批量添加用户


!

if [ $# -eq 0 ] then
  echo "Usage::--------------------------------------"
  echo "用户名作为参数，以空格隔开，批量添加用户"
  echo "eg: $0 zhangsan lisi wangwu"
  echo "---------------------------------------------"
  return 
fi


USER_LIST=$@
USER_FILE="./user.info"

for USER in $USER_LIST; do
  if ! id $USER &>/dev/null; then
    PASS=$(echo $RANDOM | md5sum | cut -c -8)
    useradd $USER
    echo $PASS | passwd --stdin $USER
    echo "$USER  $PASS" >> $USER_FILE
    echo "$USER create successful !!"
  else
    echo "$USER already exists"
  fi
done
