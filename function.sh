#!/bin/bash

# [function] name[()]{}

# 1、abbreviation function or (),but cant abbreviation both

# declare first, execute line by line
function arithmatic(){
    echo "this is a function "
}
arithmatic

# 2、arguments   $1 $2 $3.......
play(){
    # echo $[ $1+$2 ] 
    echo $(($1 + $2))
}
play 1 3

# 3、return a status of script execute (0-255)
plus(){
    echo "$@"
    return "$1"
}

plus 20 30 40 50
echo $?

dosomething() {
    if [ "$#" -eq 0 ] || [ "$1" == "--help" ]; then
        echo
        cat << EOF
参数不匹配  
请使用$0$1 查看帮助
EOF
    fi
}

dosomething "hello"
