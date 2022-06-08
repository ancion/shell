#!/bin/sh

:<<!
定义数组： 
------------------------------------
arr=(1 2 3 4 5 6 7 8 9 0)

取值
${arr[0]}

赋值 
arr[1]=10

获取数组长度 
${#arr[*]}
${#arr[@]}

!

arr=(1 2 3 4 5 6 7 8 9 0)

#取值
echo arr[0] # 需要使用取值符
echo ${arr[0]}
arr[1]=100
echo ${arr[1]}


#获取数组长度 
echo ${#arr[*]}
echo ${#arr[@]}

# 遍历数组
# for i in ${arr[@]}
for i in ${arr[*]}
do
    echo $i
done





