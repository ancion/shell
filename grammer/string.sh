#! /bin/bash


# ---------------------------------------------------------------------
# revice a input from stdin (keyboard)
# following means read input from screen and assignment to variable
# read variable    
# ---------------------------------------------------------------------

read -p "enter 1st string" st1

read -p "enter 2nd string" st2

# string with "" express differernt mean compare without it
if [ "$st1" == "$st2" ]
then 
    echo "strings match"
else
    echo  "string dont match"
fi

# compare two string 
echo "(2) compare ............................"

if [ "$st1" \> "$st2" ]
then 
    echo "$st2 is smaller than $st1"
elif [ "$st1" \< "$st2" ]
then 
    echo "$st1 is small than $st2"
else 
    echo "equals"
fi

echo "(string append)........................."

appendString=$st1$st2
echo "apend string is $appendString"

# 转换大小写
echo "(upcase or lowercase)..................."

# 行首字母大写
echo ${st1^}
# 全部大写
echo ${st1^^}
# 全部小写
echo ${st1^o}

:<<'EOF'
------------------------------------------------------
 基于字符串运算符
  =   判断字符串之间是否相等, 相等为 true, 反之 false 
  !=  检测两个字符串不相等, 不等返回 true, 反之 false
  -z  检测字符串长度是否为0，为0 则 true，反之 false
  -n  检测字符串长度是不为0, 不为0则 true，反之 false
  $   检测字符串是否不为空， 不为空则 true, 反之 false
--------------------------------------------------------
EOF

# 比较的结果返回的是：0，1 这样的数字，0 : true; 1 ： false
echo "字符串检测：以下结果： 0 为 true； 1 为 false."
[ "$st1" == "$st2" ]
echo "字符串是否相等：" $?
[ "$st1" != "$st2" ]
echo "字符串是否不等：" $?
[ -z $st1 ]
echo "字符串长度是否为0: " $?
[ -n $st1 ] 
echo "字符串的长度是否不为0: " $?
[ $st ]
echo "字符串是否为空: " $?
# ------------
echo "字符串长度：${#st1}"

: <<'EOF'
----------------------------------------------------------------------------------
字符串的截取
1、使用 expr substr $var1 start length   #(下标从1开始)
2、使用 cut -d "seperate" -c start-end   #(下标从1开始)
   > -d 指定截取的分隔符号
   > -c 指定截取字符的位置（开始位置省略从第一个开始，结束位置省略到最后一个字符）
   > -f 指定分割之后取那一段
3、使用 ${var1:start:length}
----------------------------------------------------------------------------------
EOF

# --------------------------------
# 1、使用 expr substr $va1 start length
# 这时候字符串的中字符位置开始位置为 1
var1=centos8.0

# 截取 var1 中的 2 位置开始之后的 7个字符
expr substr $var1 2 7

# cut 截取 2-7 位置的字符
echo $var1 | cut -c 2-7
echo $var1 | cut -c 2-
echo $var1 | cut -c -7
echo $var1 | cut -d "." -f1

# --------------------------------
# 截取字符串, 指定截取的起始位置和长度，这时候字符串的索引是从 0 开始计数,前包后不包
# 可以省略起始位置，默认从开始位置截取
echo ${var1:1:5}
echo ${var1::4}

:<<'EOF'
--------------------------------------------------------------------------------
字符串的替换
1、基于 ${var/old/new} 进行字符的替换
# ${var1/old/new}    # 替换第一个匹配的字符
# ${var1//old/new}   # 替换所有匹配的字符

2、基于 tr 的字符替换 -->  tr 的替换是基于单个字符的一一替换
tr "or" "OE" 将所有的 "o" 替换成 "O", "r" 替换成 "E"
tr -d  ":" 删除对应的字符 :

EOF

# -----------------------
var2="root:x:0:0:root:/root:/bin/bash"
UN="unicorn"
# 替换全部匹配的字符
echo ${var2//root/$UN}

# -----------------------
# tr 的替换是基于单个字符的一一替换
echo $var2 | tr "or" "O"  # 将所有的 "o" 替换成 "O", 将所有的 ”r" 也替换成 "O"
echo $var2 | tr -d ":"    # 删除所有的 ":"

:<<'EOF'
-------------------------------------------------------------------------------------
随机字符串
> 随机数变量 RANDOM
> 特殊设备文件 /dev/urandom （含有特殊字符）
> UUID 生成命令：uuidgen (以数字字母组成，使用 - 连接)
-----生成只含有数字字母的字串
> md5sum 会对输入的文本提取一个 256 位（32 个字符）的 MD5 编码值, 输入不同，输出不同

EOF

echo "-----------------------"
echo 'uuid: '`uuidgen`
# echo '/dev/urandom: '`head -1 /dev/urandom`

# 测试 md5sum 编码结果
echo $RANDOM | md5sum
head -1 /dev/urandom | md5sum

# 截取一个8位随机字串
echo $RANDOM | md5sum | cut -c -8
echo $RANDOM | md5sum | cut -c -16
uuidgen | tr -d "-"





