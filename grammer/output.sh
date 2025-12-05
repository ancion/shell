#!/usr/bin/env bash

# output have two type STDOUT STDERR
# to different file
ls -al 1>success.log 2>error.log

# to same file 
ls -la >file.txt 2>&1

ll >file.txt 2>&1

# the same result as top 
ll >& file.txt
