#!/bin/bash

:<<!
-------------------------------------------------------------------
uniq 对排序后的文本进行重复, 这个函数的去重是去掉连续位置的去重,
当我们需要全局去重的时候，需要先对操作范围内的内容先进行排序，然后
再进行去重

  > -c 对重复内容进行计数 
!

cat ./temp/passwd | cut -d : -f 7 | sort | uniq  -c