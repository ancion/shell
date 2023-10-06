#!/bin/bash

:<<'EOF'
-----------------------------------------------------------------------
linux 系统命令参数长度有限制
------------------------------------
 - getconf MAX_ARG       # 获取的最大的参数长度
 - ls -lh $(find /path)  # path 中文件过多的时候会出现，参数过长
----------------------------
1、 解决方案
 利用 find path -exec [command] 查找处理

2、xargs 提供参数组来进行处理
  - 以行为单位对参数进行分组（一行执行一次命令）
  - 提供参数的命令 | xargs 目标命令(默认是echo)
  - xargs --arg-file 目标命令(默认是echo)
  - I{} 定义一个变量来接收分割后的参数
  - d "sep" 对接收到的参数组还可以自己指定分割符号进行再分割

EOF

# 1、----------------------------
# 每找到一条就交给 ls -lh 的 {} 作为参数来显示
# find / -exec ls -lh {} \
# find /home/unicorn/ | xargs ls -lh 

# 2、使用 {} 接收分割后的参数变量
ls ./temp/* | xargs -I {}  echo {}
ls ./temp/* | xargs -I {} cp {} {}.bak
ls -ls ./temp
# 删除文件
rm -rf ./temp/*.bak

head -1 ./temp/passwd | xargs -d ":" -I{} echo {}


