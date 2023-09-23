#!/bin/bash

# about file type
# -f file existence and is a normal file 
# -e file existence
# -d file existence and is a dictionary 
# -r file 是否具有读取权限
# -w file 是否具有可修改权限
# -x file 是否具有执行权限


if [ -d temp/test ]
then 
    echo "Here is a test direction,you can user it to test you script"
else
    echo "makedir test"
    mkdir temp/test
fi

if [ -f temp/test/test.txt ]
then
    echo "temp/test/ alread have a file named test.txt"
else
    echo "create test.txt"
    touch temp/test/test.txt
fi

if [ -e temp/test/test.txt ]
then
    echo "hello world" >> temp/test/test.txt
    cat temp/test/test.txt
else
    echo "error find a file name test.txt in temp/text"
fi

# user -x -w -r in ifstatemnt can check premission of file 
for file in `ls`
do
    if [ -x $file ]
    then
        echo -e "$file ......>> is a script"
    else
        echo "$file ......>> is a text"
    fi
done
