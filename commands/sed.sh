#!/bin/bash

# stream tool sed

# recieve regex  as argument
#  sed {scope}command{argument} filename

#  d delete
#  a append at next line
#  i insert insert at front line 
#  p print  

echo "completion......................................."
ip address | grep inet6 
echo "delete line1-3..................................."
ip address | grep inet6 | sed '1,3d'
echo "delete line13...................................."
ip address | grep inet6 | sed '13d'
echo "delete line2....................................."
ip address | grep inet6 | sed '2d'
echo "find contain 'inet6' and /host/ line append xxxxxxx........."
ip address | grep inet6 | sed '/host/a xxxxxxx'


# s replace
echo "replace.........................................."
ip address | grep inet6 | sed '1,3s/inet/apple/g'

# -e execute more than one command in line
# {} 组合多个命令，命令之间使用分号间隔
echo "-e argument......................................"
ip address | grep inet6 | sed -e '1,3s/inet/apple/g' -e '4,6d'

# -i change source file (default not change source file) 
echo "-i arguments....................................."
ip address > temp/ipfile
wc -l temp/ipfile
sed '1,3d' temp/ipfile > /dev/null
wc -l  temp/ipfile
sed -i '1,3d' temp/ipfile >/dev/null
wc -l  temp/ipfile

# -f  指定处理的脚本
# -r  使用扩展的正则表达
# -n  not show default output 
