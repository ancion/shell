#!/usr/bin/env bash
backup() {

        HISTORY_DIR=${BASE_DIR}/version$(date +"%Y%m%d%H%M%S")
        mkdir ${HISTORY_DIR}

        mv ${BASE_DIR}/lib/odn-utils-0.0.1-SNAPSHOT.jar  ${HISTORY_DIR}/odn-utils-0.0.1-SNAPSHOT.jar
        mv ${BASE_DIR}/lib/odn-common-model-1.0-SNAPSHOT.jar ${HISTORY_DIR}/odn-common-model-1.0-SNAPSHOT.jar
        mv ${BASE_DIR}/lib/odn-dubbo-interface-0.0.1-SNAPSHOT.jar ${HISTORY_DIR}/odn-dubbo-interface-0.0.1-SNAPSHOT.jar
        mv ${BASE_DIR}/odn-* ${HISTORY_DIR}/
}

deploy() {
        backup

        cp ${BASE_DIR}/package/odn-common-model-1.0-SNAPSHOT.jar ${BASE_DIR}/lib
        cp ${BASE_DIR}/package/odn-utils-0.0.1-SNAPSHOT.jar ${BASE_DIR}/lib
        cp ${BASE_DIR}/package/odn-dubbo-interface-0.0.1-SNAPSHOT.jar ${BASE_DIR}/lib
        cp ${BASE_DIR}/package/odn-equipment-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
        cp ${BASE_DIR}/package/odn-order-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
        cp ${BASE_DIR}/package/odn-base-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/

        start
}


restart() {
  stop
  start
}

stop () {

        echo "============================================================="
        echo " 程序正在停止"
        echo "============================================================="
        echo ""
        kill -9 `jps -l | grep odn- | awk '{print $1}'` >& /dev/null
}

start() {

        echo ""
        echo "============================================================="
        echo " 程序正在启动"
        echo "============================================================="

        # 启动 base 程序
        nohup java -jar -Dspring.profiles.active=test -Dloader.path=./lib_new -Ddubbo.application.logger=slf4j odn-base-service-0.0.1-SNAPSHOT.jar >logs/odn-base-service-`date +%Y-%m-%d`.out 2>&1 &
        echo "启动 base 程序"
        sleep 20

        # 启动 eqp 程序
        nohup java -server -Xmx4G -Xms1G -Dspring.profiles.active=test -jar -Dloader.path=./lib_new -Ddubbo.application.logger=slf4j  odn-equipment-service-0.0.1-SNAPSHOT.jar >logs/odn-equipment-service-`date +%Y-%m-%d`.out 2>&1 &
        echo "启动 eqp 程序"
        sleep 30

        # 启动 order 程序
        nohup java -jar -Dspring.profiles.active=test -Dloader.path=./lib_new -Ddubbo.application.logger=slf4j odn-order-service-0.0.1-SNAPSHOT.jar >logs/odn-order-service-`date +%Y-%m-%d`.out 2>&1 &
        echo "启动 order 程序"
        sleep 20

        echo ""
        echo "============================================================="
        echo " 程序启动完成"
        echo "============================================================="
}

case $1 in
    "start")
        start;;
    "stop")
        stop;;
    "restart")
        restart;;
    "backup")
        backup;;
    "deploy")
        deploy;;
    *)
        echo "------------------------------------------------------"
        echo "Usage: app_run.sh [commands ...]"
        echo "You could choose one of following commands"
        echo "------------------------------------------------------"
        echo "start          --start   app"
        echo "stop           --stop    app"
        echo "restart        --restart app"
        echo "backup         --backup  app"
        echo "deploy         --deploy  app backup version and deploy package"
        echo "------------------------------------------------------"
        ;;
esac
