#!/bin/bash

:<<!
---------------------------------------------------------------
tac 作用是 以行为单位的将文件内容倒序输出
rev 作用是 在行内从右往左输出文本字符串内容
!

# 从最后一行逐行输出直到第一行

# 删除倒数的1,5 行
tac ./temp/passwd | sed 1,5d | tac 
# 截取每一行的最后8 个字符
cat ./temp/pass | rev | cut -c -8 | rev
