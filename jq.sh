#!/usr/bin/env bash

:<<'EOF'

jq 命令: 在命令行中处理 json 数据,便于直接在 shell 脚本处理数据
------------------------------------------------------------------------------------
JSON 是一个轻量化的数据交换格式,其采用完全独立于语言的文本格式，具有方便人阅读和编写，
同时也易于机器的解析和生成。这些特性决定了JSON格式越来越广泛的应用于现代的各种系统中。

>>> 需要说明的是 jq 只能接受 well form 的 JSON 字符串作为输入内容。
    也就是说输入内容必须严格遵循 JSON 格式的标准。所有的属性名必须是以双引号包括的字符串。
    对象的最后一个属性的末尾或者数组的最后一个元素的末尾不能有逗号。
    否则 jq 会抛出无法解析 JSON 的错误。
<<<

 + 常用的命令
 ----------------------------------------------------------------------------------------------------
 
   > `.` 单独的一个 `.`符号用来表示对作为表达式输入的整个 JSON 对象的引用。
   > JSON 对象操作：jq 提供两种基本表达式用来访问 JSON 对象的属性 ’.’和’.?’
     - `.` 后面接一个对象的属性, 用于访问对象的属性，对象不包含对应的属性则返回 `null`
     - `.?` 后面接一个对象的属性，用于访问对象的属性，对象不包含对应的属性则返回 `null`
     - 两者的不同点在于，当输入不是一个 json 对象或者数组的时候，使用了 `.` 会抛出异常, 而 `.?` 无任何输出
   > JSON 数组操作：jq 提供三种基础表达式来操作shuzu
     - `.[]` 该表达式的输入可以是数组或者json对象，输出是基于数组元素或者json对象属性的 iterator
     - `.[index]` 或者 `.[attributename]` 访问数组元素或者json对象的特定属性，输出是单个值
     - `.[startindex:endindex]` 对数组进行切片, 类似于 python 中的切片操作
   > 表达式操作(`,`, `|`): 用于关联多个基础表达式
     - `,` 表示对同一个输入应用多个表达式
     - `|` 表示将前一个表达式的输出作为后一个表达式的输入
     - 当一个表达式产生的结果是一个迭代器的时候，会将迭代器的每一项都作为后一个表达式的输入，
 
 + 内置运算
   > jq 支持的数据类型有：数字，字符串，数组，对象
   > 数学运算，
     - 对于数字类型，jq 实现了基本的 加减乘除和求余(%)的运算,对于除法运算，jq 最多支持 16 位小数
   > 字符串操作
     - jq 提供字符串的拼接运算(运算符`+`)
     - 字符串的复制操作 ('a'* 3 结果为 `aaa`)
     - 字符串的分隔操作 (`sas` 拆分表达式 `"sas"/"a"` 结果为 `["s", "s"]`)

EOF

# xxx.JSON是我们要处理的JSON数据，我们可以直接将文件名传给jq
 jq -r '.' xxx.JSON

# 或者由其他程序读出文件内容，并传给jq
 cat "xxx.json" | jq -r '.'


# 单个值获取，解析不存在的元素，会返回null
curl 'https://www.jianshu.com/users/da1677475c27/publications?page=1&count=10'|jq '.publications'

# 嵌套解析，注意：json 数组的键命名必须为下划线"_"，不能为"-"，否则解析不了。解析不存在的元素，会返回null
curl 'https://www.jianshu.com/users/da1677475c27/publications?page=1&count=10'|jq '.publications[1].name'

# 内建函数-key,用来获取JSON中的key元素
curl 'https://www.jianshu.com/users/da1677475c27/publications?page=1&count=10'|jq 'keys'

# 内建函数-has,用来是判断是否存在某个key
curl 'https://www.jianshu.com/users/da1677475c27/publications?page=1&count=10'|jq 'has("publications")' 


:<< EOF
======================
demo.json

######################
{
  "code": 0,
  "msg": "",
  "store_name_list": [{
    "store_name": "gmail-demo-1"
  }]
}

# 对已有的 json 数组进行复制翻倍
---
echo `cat demo.json | jq '.store_name_list += .store_name_list'`
--- 
{
  "code": 0,
  "msg": "",
  "store_name_list": [{
    "store_name": "gmail-demo-1"
  },
  {
    "store_name": "gmail-demo-1"
  }]
}
######################
EOF



