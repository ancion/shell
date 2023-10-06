#!/bin/bash

# sort
: <<'EOF'
---------------------------------------------------
sort file         # 对文件内容进行排序，
command | sort    # 接收某个命令作为排序参数
  > -t sort seperate
  > -k sort column
  > -n sort by number (default by String) 
  > -r sort  reverse
  > -u delete duplicate content

EOF

ls -la | sort -t " " -n -r -k 5
echo ".............................."
ls -la | sort -t " " -n -k 5
echo ".............................."
ls -la | sort -t " " -k 5
  
