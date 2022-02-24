#! /bin/bash

echo 'command usually used when you want filter content'


# 用于输出包含 AAA 但是不包含 BBB 的行
ls | grep 'AAA' | grep -v 'BBB' 

# -v 表示取反，不包含
# -e 表示支持正则表达式, 后面的过滤规则可以书写正则表达式。


