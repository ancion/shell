#!/usr/bin/env bash

: <<'EOF'
awk a stream tool of shell
----------------------------------------------------------------------
--- integrate syntax, you only write the section that you use

awk '
    BEGIN { }  execute before read content
          { }  execute once every line
    END   { }  execute after read total conntent
    '     
 
awk is a pattern action list,the stream could match every pattern,
when someone is satisfied with,then action should be execute

awk 'pattern1{action1}  pattern2{action2} ...........' filename 

-F specify the separate default（" " or tab）
-v delcare you own variable
-f write all awk commnd in a file, then can use -f reference it 

EOF

cat /etc/passwd >temp/passwd

cat temp/passwd | awk 'NR=3' # print line=3 content

: <<'EOF'
------------------------------------------------------------------
regexp fliter
----------------------------------------
 `/regex/` format
 ~   : match
!~   : unmatch

awk 'BEGIN{a="100test";if(a~/100/){print "OK"}}'
----------------------------------------
 number or string (as ASCII) compare 
== !=  : equals or not equals 
<  <=  : less than or equals 
>  >=  : more than or equals
----------------------------------------
 logic algorithem (return 0 = false, 1 = true)
 &&    : and 
 ||    : or
----------------------------------------
 support express
+  +=
-  -=
*  *=
/  /=
%  %= 
^  ^=  (*** **=) 两种写法的含义是一样的
?:     三目运算
in     判断数组中是否存在某个值
------------------------------------------------------------------
EOF

cat temp/passwd | awk '/^a/{print} /^ancion/{pirnt} /^l/{print}'
cat temp/passwd | awk -F : '/^ancion/{print $3}'
# then you can control flow  when you can print
awk -F : '
BEGIN {sum=0;print "BEGIN"}
  {sum+=$3;print $3" "sum}
END {print "END"}' temp/passwd

awk -F : -v sum=0 '{sum+=$3;print $3" "sum}END{print "END"}' temp/passwd

# built-in  variable
# -------------------------------------------------------------
# FILENAME  current handle filename
# FNR       current file row rows
# NR        current executed rows
# NF        current row(line separate with "-F '👽' ") length
# FS        seperate of every devition(input)
# RS        seperate of every line(input)
# OFS       separate of every devition(output)
# ORS       separate of every line(output)
#--------------------------------------------------------------
# more build-in variable ,command  `man awk |grep built-in`

awk -F : '{OFS="\t"}{print $1,$2,$3,$4,$5,$6}' temp/pass

awk -F : '{print "filename="FILENAME",NF="NF",NR="NR}' temp/passwd

# awk built-in function
# -------------------------------------------------------------
# toupper(content:-$0)    switch to upper case of content
# tolower(content:-$0)    switch to lower case of content
# length(content:-$0)     return length of content
# blength(string:-$0)         return string length with byte
# substr(content:-$1, start:-1, length:-4) sub string
# gensub(/regex/, "\1", 1，contenet:-$0) get substr of match regex
# index(str1,str2)  find 2 in 1 and return position with index start with 1, not exists reuturn 0
awk -F : '{print toupper($1),length($1)}{OFS="\t"}' temp/pass

# -------------------------------------------------------------
# 忽略大小写匹配
# -------------------------
awk 'BEGIN {IGNORECASE=1} /alex/{print}' temp/pass

# -------------------------------------------------------------
# awk  brach structure
# ----------------------------------
awk -F : '
  BEGIN{ i=0; j=0 }
    {
      if($3<=10){
        i++
      }else{
        j++
      }
    }
  END{ print i","j }
' temp/passwd

# awk loop structure
# ------------------------------------------------
# 1、while(condition){ handle block }
# ------------------------------------------------
awk -F [:/] '
  {i=1}{
    while(i<=NF){
      if($i!~/root/){
        j++
      };
      i++
    }
  }
END{ print j }
' temp/passwd
# -----------------------------------------------
# 2、do { handle block } while(condition)
# -----------------------------------------------
# 3、for (init;condition;step){ handle block }
# -----------------------------------------------
awk '
BEGIN
  {
    for(i=0;i<=5;i++){
      print i
    }
  }
'
: <<'EOF'

-----------------------------------------------
break       :  break current loop 
continue    :  terminal current loop, goto next loop  
next        :  skip current line, goto next line 
exit        :  exit read text，goto END{}, if not exists END{}, end awk command  

--------------------------------------------------------------------------
Array  是一种数据映射关系，
---------------------------------------
可以以任意数据为 key(可以是多个，类似函数的入参), 然后给 key 映射一个 value

1) 这里就是给第一列与第二列之间建立了映射

awk '{a[$1] = $2}{print a[$1]}' /etc/passwd  

awk '{a[1, NR] = $1; a[2,NR] = $2}'

2) 行转列 (适用于每条记录都是相同的长度)

   1 3 5 7 9 5
   2 4 6 8 0 2
   A B C D E O
   H I J K L p
   w x y F G C

END 里面使用 NF, NR 其实是最后一行的值

EOF

awk '{
    for(i=1; i<=NF; i++){
      a[NR,i]=$i
    }
  }
  END {
    for (i=1; i<=NF; i++) {
      for(b=1;b<=NR; b++) {
        if (b==1) {
          printf "\n"a[b,i]
        }else{
          printf " "a[b,i]
        }
      }
    }
  }
' text1 # text1 内容见上方的数据矩阵

hyprpm list | awk '
  BEGIN { b="start" } 
  {
    if($0~/Plugin \w+/){ b=$4; a[b]=0}; 
    if($0~/enabled/){ a[b]=$3}
  }
  END { 
    printf "["
    i=0;
    for (key in a) {
      i++; 
      printf "{" 
      printf "\""key"\": " a[key]
      if (length(a) == i) {
        printf "}"
      }else {
        printf "},"
      }
    }
    printf "]"
  }'
