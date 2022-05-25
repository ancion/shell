#!/bin/bash

if [ -d demo ]; then
  echo "demo directory already exists"
elif [ ! -f ok.sh ]; then
  echo "ok.sh file not exists"
fi
