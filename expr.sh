#!/bin/sh

: <<'EOF'
-------------------------------------------------
原生的 bash 中是不支持一般的运算的, 需要借助于expr
以下介绍一些基本的运算
-------------------------------------------------
1、计算式需要使用 `` 包裹
2、需要使用 expr 进行操作
3、表达式于运算符之间需要有空格隔开

EOF

# 加法运算
echo "2 + 2 = "`expr 2 + 2 `

# 减法运算
echo "2 - 2 = "$(expr 2 - 2)

# 乘法运算，由于 * 在bash 中有特殊含义，所以需要转译
echo "2 * 2 = "`expr 2 \* 2`

# 除法运算
echo "2 / 2 = "`expr 2 / 2`

# 赋值，赋值语法要求等号前后不能有空格
num=1532

# 自增
((num++))

echo "${num}"

# -----------------------------------------------------
# 计算的第二种方式: 算式替换
# 语法： $[整数 运算符 整数]
# 注意：
#  1、乘法操作不需要进行转译，
#  2、运算符两侧可以不需要空格，
#  3、使用引用变更可以省略 $
#  4、计算结果替换原来的表达式，要显示结果需要借助 echo
#  5、支持乘方运算 

echo $[num**2]
echo $[20-10*2/5]

