#!/bin/bash

# awk a stream tool of shell

# awk is a pattern action list,the stream could match every pattern,
# when someone is satisfied with,then action should be execute

# awk 'pattern1{action1}  pattern2{action2} ...........' filename 

# -F specify the separate default（" " or tab）
# -v delcare you own variable
# -f write all awk commnd in a file, then can use -f reference it 

cat /etc/passwd > temp/passwd

cat temp/passwd | awk 'NR=3'  # print line=3 content

# ------------------------------------------------------------------
# redexp fliter
# ----------------------------------------
#  `/regex/` format
#  ~   : match
# !~  : unmatch
# 
# ----------------------------------------
#  number or string  compare 
# == !=  : equals or not equals 
# <  <=  : less than or equals 
# >  >=  : more than or equals
# ----------------------------------------
#  logic algorithem
#  &&    : and 
#  ||    : or
#-----------------------------------------
#  support express
# +  +=
# -  -=
# *  *=
# /  /=
# %  %=
#-------------------------------------------------------------------


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
# NR        current executed rows
# NF        current row(line separate with "-F '👽' ") length
# OFS       separate of every devition
#--------------------------------------------------------------
# more build-in variable ,command  `man awk |grep built-in`

awk -F : '{OFS="\t"}{print $1,$2,$3,$4,$5,$6}' temp/pass

awk -F : '{print "filename="FILENAME",NF="NF",NR="NR}' temp/passwd

# awk built-in function 
# toupper()    switch to upper case of content
# tolower()    switch to lower case of content
# length()     return length of content
# gensub(/regex/, "\1", 1， $0) get substr of match regex 

awk -F : '{print toupper($1),length($1)}{OFS="\t"}' temp/pass


# ------------------------------------------------------------------------------
# 忽略大小写匹配
# -------------------------
awk 'BEGIN {IGNORECASE=1} /alex/{print}' temp/pass


# ------------------------------------------------------------------------------
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
# -----------------------------------------------
# break       :  break current loop 
# continue    :  terminal current loop, goto next loop  
# next        :  skip current line, goto next line 
# exit        :  exit read text，goto END{}, if not exists END{}, end awk command  

