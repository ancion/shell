#!/bin/bash

YEAR=$(date -d "yesterday" +"%Y")
MONTH=$(date -d "yesterday" +"%m")
DAT=$(date -d "yesterday" +"%d")
PROJECT_DIR=/DDTX/dubbo/odn-dubbo
COMPRESS_FILENAME=${YEAR}${MONTH}-${DAT}-log.tar.gz
# 切分日志的规则
RULE=""

case $DAT in
  '10')
    RULE=odn-*-${YEAR}-${MONTH}-0{0..9}
    ;;
  '20')
    RULE=odn-*-${YEAR}-${MONTH}-1{0..9}
    ;;
  '28')
    RULE=odn-*-${YEAR}-${MONTH}-*
    ;;
  '29')
    RULE=odn-*-${YEAR}-${MONTH}-*
    ;;
  '30')
    RULE=odn-*-${YEAR}-${MONTH}-*
    ;;
  '31')
    RULE=odn-*-${YEAR}-${MONTH}-*
    ;;
  *)
    return 1
esac
echo $COMPRESS_FILENAME
echo $RULE

tar -czvf ${COMPRESS_FILENAME} ${PROJECT_DIR}/applogs/${RULE}
mv ${PROJECT_DIR}/applogs/${COMPRESS_FILENAME} ${PROJECT_DIR}/historylogs/
rm -rf ${PROJECT_DIR}/applogs/${RULE}


