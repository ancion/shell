#! /bin/bash

echo 'this command coudle make multi output to different position'

# 这个命令可以同时将输出指向标准输出（终端窗口）和后面的文件

ls | tee -a temp/tee.txt

# -a 参数表示在ls.txt 文件中是追加内容
