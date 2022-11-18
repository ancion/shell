#!/bin/bash

echo "接收参数的数量:" $#   #argc
echo "接收参数的内容:" $@   #argv[0]之后的
echo "程序的名字:" $0 #argv[0]

echo "遍历参数如下:"

for i in $@  #$@用户输入参数的集合
do
    echo $i,  当前参数总个数为: $#
done

#这些依次保存用户输入的参数，但是最多到$9
echo $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14

echo "使用shift命令之后....."

for i in $@
do
    echo $1, 当前参数总个数为: $#
    shift #将当前的参数最左侧的剔除掉，后一个变成了第一个
done
