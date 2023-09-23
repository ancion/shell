#! /bin/bash

#  $1 $2 $3 $4  this is the arguments that you typed after your bash command 
#  $0 you typed command
# when you execute this script type "./input.sh  BEM TOYOTO HONDA"
echo  $0 $1 $2 $3

# you can show all argument with $@
args=("$@")

echo ${args[0]} ${args[1]} ${args[2]}  

#  $@ you typed arguments list 
#  $* you typed arguments a String

echo "$@"
echo "$*"
#  $# number of you arguments
echo $#

# $? the result of last script,return 0(success) or 1(failure)  

#
echo "().................................................."

while read line
do
    echo $line

done < ${1:-/dev/stdin}

read -p "wirte something in 7 seconds:>> " -t 7 baba 
echo "what the $baba"
