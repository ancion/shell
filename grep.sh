#! /bin/bash

echo 'command usually used when you want filter content'



# 用于输出包含 AAA 但是不包含 BBB 的行
ls | grep 'AAA' | grep -v 'BBB' 

# -v 表示取反，不包含
# -E 表示支持扩展正则表达式, 后面的过滤规则可以书写正则表达式。
# -i 表示忽略大小写
# -o 表示只输出匹配的内容，而不是整行
# -n 表示只输出匹配的行号
# -r 表示忽略目录 (搜索所有的文件以及子目录)

