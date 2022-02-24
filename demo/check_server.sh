#!/bin/bash

:<<!
------------------------------------------------------------
测试服务的可用性 （http）
---------------------------------
!


USR_LIST="www.baidu.com www.ctnrs.com www.csdn.com"
for URL in $USR_LIST; do
  FAIL_COUNT=0
  # 对每个网站访问请求三次， 只要一次成功就认为成功并中断该网站的重试
  # 三次全部失败就认为该网站不可用，进行后续处理 (发送邮件给管理员)
  for ((i=1;i<=3;i++)); do
    HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $URL)
    if [ $HTTP_CODE -eq 200 ]; then 
      echo "$URL OK"
      break
    else
      echo "retry $FAIL_COUNT"
      # 使用let 完成变量的自增
      let FAIL_COUNT++
    fi
  done
  if [ $FAIL_COUNT -eq 3 ]; then
    echo "Warning: $URL access failure!"
  fi
done
 
