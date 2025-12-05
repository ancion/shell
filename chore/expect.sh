#!/usr/bin/expect

:<< 'EOF'
-------------------------------------------------
第一行为脚本指定解释器
--------------
expect 进行交互式的命令执行，将预编写好的脚本按照一定的
预期结果发送相应的命令完成交互过程，
> 主要应用于远程连接其他服务器完成一些操作 （ssh/ftp）

EOF


# 以下就是一组 ssh 远程登录其他服务器并在服务器上
# 构建一个文件并在里面出入内容的示例
set host 192.168.64.111
set user unicorn
set password opop
spawn ssh $user@$host   # 创建交互式进程
expect "password:" {send "$password"}
expect "\[$user\@" {send "pwd>/tmp/$user.txt;exit;\r"}

expect eof  # 结束指令

