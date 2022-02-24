#!/bin/bash

:<<!
-------------------------------------------------------------
日志按照天来进行切割备份
1、默认的 nginx 不支持按照天来进行日志的切分,
   -- 当我们将原日志文件移走之后或者删除后，nginx 持有的文件描述符将是一个无效
      的描述符，不会重新生成新的文件，需要使用到下面的命令.
2、nginx 自定义了一个信号，可以重新生成一个文件描述符，然后将日志生成到新的文件中

    kill -USR1 $(cat /var/run/nginx.pid)

-------------------------------------------------------------
!

divide_by_day(){
    LOG_DIR=/usr/local/nginx/logs
    # 切割日志一般在零点触发, 获取上一天的时间
    YESTEDAY_TIME=$(data -d "yesterday" +%F)
    LOG_MONTH_DIR=${LOG_DIR}/$(date +"%Y-%m")
    # 这里支持文件列表，使用空格间隔开来
    LOG_FILE_LIST="access.log"
    for LOG_FILE in ${LOG_FILE_LIST}; do
        [ ! -d "${LOG_MONTH_DIR}" ] && mkdir -p "${LOG_MONTH_DIR}"
        mv "${LOG_DIR}/${LOG_FILE}" "${LOG_MONTH_DIR}/${LOG_FILE}_${YESTEDAY_TIME}"
    done

    # nginx 发送信号重新生成日志
    kill -USR1 $("cat /var/run/nginx.pid")
}

