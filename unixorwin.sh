#!/bin/bash

:<<'EOF'
------------------------------------------------------------------------
windows 系统文本区别
------------------------
换行：
  windows:  \r \n 
  unix   :  \n 
------------------------
借助文本转换工具，将文本中系统区别的文件内容进行转换
unix2dos filename   # unix 文本转换为 dos  系统文本
dos2unix filename   # dos  文本转换为 unix 系统文本 

EOF
