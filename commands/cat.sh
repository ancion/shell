#!/usr/bin/bash

# 使用 如下的格式将 EOF 中的内容发送给 cat，包含了其中的缩进的空格
# 但是结束的 EOF 必须顶格写才符号语法规范
cat << EOF 
hello 
  world
EOF


#  当我们需要保持缩进的时候又不想让 EOF结束符号顶格破坏我们全局的缩进
#  需要在 在 << 后添加 -

name="Alex"

use_var() {
  cat <<- EOF
    hello $name
      workd
EOF
}

only_test() {
  cat <<- "EOF"
    hello $name
      workd
EOF
}

use_var 
only_test 
