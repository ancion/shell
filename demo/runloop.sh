#!/usr/bin/env bash
#
for((i=0; i < 1000; i++ )) do
  echo `date "+%F %H:%M:%S"` >> d.log
  sleep 1
done
