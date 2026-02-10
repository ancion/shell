#!/bin/env bash
BASE_DIR=/DDTX/dubbo/odn-service/
OPERATION=$1

check(){
    if [ ! -f "${BASE_DIR}/package.tar.gz" ]; then 
        echo "-------->>package.tar.gz 软件包不存在<<-----------"
        exit 1
    fi
}

stop(){
    jps -l | grep odn | awk '{print $1}' | xargs kill -9
}

start(){
    cd ${BASE_DIR} || exit 1   

    echo ""
    echo "============================================================="
    echo " 程序正在启动"
    echo "============================================================="


    # 启动 base 程序
    nohup java -jar -Dspring.profiles.active=preview -Dloader.path=./lib -Ddubbo.application.logger=slf4j odn-base-service-0.0.1-SNAPSHOT.jar >logs/odn-base-service-`date +%Y-%m-%d`.out 2>&1 &
    echo "正在启动 odn-base-service"
    sleep 20

    # 启动 eqp 程序
    nohup java -jar -Dspring.profiles.active=preview -Dloader.path=./lib -Ddubbo.application.logger=slf4j odn-equipment-service-0.0.1-SNAPSHOT.jar >logs/odn-equipment-service-`date +%Y-%m-%d`.out 2>&1 &
    echo "正在启动 odn-eqp-service"
    sleep 30

    # 启动 order 程序
    nohup java -jar -Dspring.profiles.active=preview -Dloader.path=./lib -Ddubbo.application.logger=slf4j odn-order-service-0.0.1-SNAPSHOT.jar >logs/odn-order-service-`date +%Y-%m-%d`.out 2>&1 &
    echo "正在启动 odn-order-service"
    sleep 20

    # 启动 cable 程序
    #nohup java -jar -Dspring.profiles.active=preview -Dloader.path=./lib -Ddubbo.application.logger=slf4j odn-digital-cable-0.0.1-SNAPSHOT.jar>logs/odn-digital-service-`date +%Y-%m-%d`.out 2>&1 &
    #echo "正在启动 odn-cable-service"
    #sleep 20

    echo ""
    echo "============================================================="
    echo " 程序启动完成"
    echo "============================================================="
   
}

restart() {
    stop
    sleep 2
    start
}

backup() {
    HISTORY_DIR=${BASE_DIR}/historyVersion/
    VERSION=$(date +"%Y%m%d-%H%M%S")
    if [ ! -d "${HISTORY_DIR}/${VERSION}" ]; then 
        mdir -p ${HISTORY_DIR}/${VERSION}
    fi
    mv ${BASE_DIR}/odn-* ${HISTORY_DIR}/${VERSION}
    mv ${BASE_DIR}/lib/odn-* ${HISTORY_DIR}/${VERSION}
}

deploy() {
    check 
    backup

    mv ${BASE_DIR}/package/odn-common-model-1.0-SNAPSHOT.jar   ${BASE_DIR}/lib
    mv ${BASE_DIR}/package/odn-dubbo-interface-0.0.1-SNAPSHOT.jar ${BASE_DIR}/lib
    mv ${BASE_DIR}/package/odn-utils-0.0.1-SNAPSHOT.jar  ${BASE_DIR}/lib
    mv ${BASE_DIR}/package/odn-base-service-0.0.1-SNAPSHOT.jar  ${BASE_DIR}/
    mv ${BASE_DIR}/package/odn-data-delivery-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
    mv ${BASE_DIR}/package/odn-equipment-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
    mv ${BASE_DIR}/package/odn-order-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/

    restart
}


case $OPERATION in 
    "deploy")
         deploy;;
    "restart")
         restart;;
    "stop")
         stop;;
    *)
       echo 'usage | start | stop | restart'
esac
