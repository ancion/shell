#!/usr/bin/bash

# make a generic java app run command and some jvm option config

# ---------------------------------------------------------------
# this app_run.sh aim to jar start stop restart,
# ---------------------------------------------------------------
# 1、yous should make this file together with you app jar file
# 2、remenber add executable permission to this app_run.sh
#             chmod +x app_run.sh
# ---------------------------------------------------------------
# ./app_run.sh start     # start this app 
# ./app_run.sh stop      # stop this app 
# ./app_run.sh restart   # restart this app 

# get current file path Folder
SHELL_FOLDER=$(cd "$(dirname "$0")"; pwd)

# declare you will run app file 
APP_JAR="odn-data-delivery-0.0.1-SNAPSHOT.jar"

# declare a log path in current Folder
LOG_PATH=$SHELL_FOLDER/logs

# config your jvm runtime argumnets 
JAVA_OPTS="
-server
-Xms1G
-Xmx2G
-XX:+AlwaysPreTouch
-XX:+PrintGCDetails
-XX:+PrintGCTimeStamps
-XX:+PrintGCCause
-Xloggc:$LOG_PATH/gc.log
-XX:+HeapDumpOnOutOfMemoryError
-XX:+HeapDumpPath=$LOG_PATH/heapdump
-Dfile.encoding=utf-8
-Dspring.profiles.active=zjprod
"

# start your app
start(){
    # create log directory if not exists
    if [[ ! -d "$LOG_PATH" ]]; then
        mkdir "$LOG_PATH"
    fi
    # start your app with configure and output log to log path
    nohup java $JAVA_OPTS -jar $SHELL_FOLDER/$APP_JAR > $LOG_PATH/console.log 2>&1 &

    echo "app $SHELL_FOLDER/$APP_JAR started."
    echo "JAVA_OPTS: $JAVA_OPTS"
}

# stop your app
stop(){
    # find you app process and kill it 
    ps -ef|grep $SHELL_FOLDER/$APP_JAR |grep -v grep |awk '{print $2}' |xargs kill -9
    echo "app $SHELL_FOLDER/$APP_JAR is stoped."
}

# restart your app 
restart(){
    stop
    start
}

#------------------------------------------------------------------------
# handle you argument when you execute this file 
echo "APP_HOME: $SHELL_FOLDER"
case $1 in 
    "start")
        start;;
    "stop")
        stop;;
    "restart")
        restart;;
    *)
        echo "------------------------------------------------------"
        echo "Usage: app_run.sh (commands ...)"
        echo "You could choose one of following commands"
        echo "------------------------------------------------------"
        echo "start          --start   app"
        echo "stop           --stop    app"
        echo "restart        --restart app"
        echo "------------------------------------------------------"
        ;;
esac

