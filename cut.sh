#!/bin/bash

# user -x -w -r in ifstatemnt can check premission of file 
for file in `ls`
do
    if [ -x $file ]
    then
        echo -e "$file ......>> is a script"
    else
        echo "$file ......>> is a text"
    fiS
done
