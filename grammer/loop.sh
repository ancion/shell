#!/usr/bin/env bash

# this capital we introduce the loop statement 
# loop statement we frequently used 
# ----------------------------------------------------
# until   [test statements]    do  codeblock
# while [test statements] do codeblock
# for((test statement)) do codeblock done

# Here are three example

number=0
echo "(1)...................................................."
until [ $number -gt 5 ]
do
    echo $number
    number=$((number+1))
done


echo "(2)...................................................."
while [ $number -gt 5 ]
do
    echo $number
    number=$((number+1))
    if [ $number -gt 10 ]
    then
        break
    fi
done

echo "(3)...................................................."
for (( i=0;i<10;i++ ))
do
    if [ "$i" -eq 3 -o "$i" -eq 7 ]
    then
        continue
    fi
    echo $i
done

echo "(......another for)"
for i in {1..10}
do
    if [ "$i" -eq 5 -o "$i" -eq 10 ]
    then
        echo "$i"
    fi
done
echo "(......another for2)"
for i in 1 2 4 6 8
do 
    echo "$i"
done

echo "(......another for3)"
for i in $(seq 1 10)
do
    echo "$i"
done

echo "(5)...test string............................."
list="rootfs user data data2"
for i in $list
do
    echo "$i"
done

echo "(6)...test file..............................."
for file in /home/*;
do
    echo "$file is file path \!"
done

# for in frequently used ,because after in we could recive function returned value
# for example $(),``

echo "(............for advanced use.................)"
echo "(......\$()......)"
for file in $(ls *.sh)
do 
    echo "$file"
done

echo "(....\`\`.........)"
for file in `ls`
do
    echo "$file"
done
