#!/bin/bash

:<<!
-------------------------------
找出cpu / 内存占用较高的应用
-----------
ps 

> -o 可以自定义输出列，具体可以使用 ps --help 查看有哪些选项

!
echo "------------- cpu top 10 -----------------------"
ps -eo pid,pid,pcpu,pmem,args --sort=-pcpu | head -n 10

echo "------------- mem top 10 -----------------------"
ps -eo pid,pid,pcpu,pmem,args --sort=-pmem | head -n 10
