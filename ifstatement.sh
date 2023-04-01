#! /bin/bash

if [ -d demo ]; then
  echo "demo directory already exists"
fi
if [ ! -f ok.sh ]; then
  echo "ok.sh file not exists"
fi

# Noticing...................................................
# space is very import in bash script
# this is must have no when you  declare a variable
count=10
# There must has a space when you use brackets
# You can use [] around you test statement, then you must use following express
# this expr is only support number and number, can't compare string exclude numner string

#  -lt   means   less than
#  -le   means   less than  or equals
#  -gt   means   great than
#  -ge   means   great than  or equals
#  -eq   means   equals 
#  -nq   means   not equals 
#  -o    means   or
#  -a    means   and
#  !     means   reverse result

echo "(1).................................................."
if [ $count -lt 9 ]
then
    echo "this is a number less than 9"
else
    echo "this is number great than 9"
fi

# If you just use (()) around you test statement,differently,you must use double
# you can use following symbol express you statement

#   >
#   <
#  >=
#  <=
#  ==
# Noticing..................................................
# when you statement is mathing a statement ahead another,
# then behind statement not working
echo "(2).................................................."
if (( $count <= 10 ))
then
    echo "this is a number not more than 10"
elif (( $count == 10 ))
then
    echo "this is 10"
else
    echo "this is number grate than 10"
fi
 
# when you have more than one statement,you could use 
# && express and ,
# || express or

echo "(3).................................................."
age=80
if [ $age -lt 50 ] && [ $age -gt 18 ]
then
    echo "this is gold age"
elif [ $age -gt 50 ] || [ $age -lt 18 ]
then
    echo "Them are not the main worker for current world"
fi

# If you want use && or || in [], there must be double [[ ]]
age=30
if [[ $age -lt 25 && $age -gt 16 ]]
then 
    echo "a beatiful girl"
elif [[ $age -gt 25 || $age -lt 16 ]]
then
    echo "just in different period  of life "
else
    echo "error"
fi

# you can use "-a" express && , "-o"  express || in []
#  "=" "==" "!=" this is used comparing string, 
# can't use `-eq` , `-gt` , `-lt`

gendar="male"
if [ $age -gt 25 -a "$gendar" == "male" ]
then
    echo "This is a 25 years old man"
elif [ "$gendar" == "female" -o $age -eq 30 ]
then
    echo "that is"
else
    echo "not this"
fi

# swith case 
echo "(case).................................."
case $age in
    "25")
        echo "25";;
    "30")
        echo "30";;
    "40")
        echo "40";;
    *)
        echo "eles"
esac

# --------------------------------------------------------------
# 测试 表达式
# 1、test expresssion args && echo "Yes"
# 2、[ expression ]


