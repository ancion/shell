
#!/bin/bash
:<<EOF
APP_NAME="odn-data-delivery-0.0.1.SNAPSHOT.jar"
APP_HOME="/DDTX/Data_Delivery"
HOST="188.104.108.108 188.104.108.111 188.104.108.113 188.104.108.115"
for ip in $HOST
do
	echo "开始启动--${ip}--服务"
  if [ ! -d ${APP_HOME}/HistoryVersion ]; then
    mkdir -p ${APPP_HOME}/HistoryVersion/
  fi
  ssh root@${ip} "mv ${APP_HOME}/${APP_NAME} ${APP_HOME}/HistoryVersion/${APP_NAME}_$(date '+%Y%m%d%H%M%S')"
  scp ${APP_NAME} root@${ip}:${APP_HOME}/
  ssh root@${ip} "sh run.sh restart"
done

EOF

