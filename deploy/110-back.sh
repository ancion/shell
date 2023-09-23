
######################################################################
#  此 脚本用于 110 上分发后端项目，并调用目标服务器上的脚本解压部署
#  接受三个参数 最后一个参数为操作

STORE_PATH=/DDTX/deploy/store/digitalBack
APPNAME=package
LOCAL_PATH="/DDTX/service-api"
REMOTE_PATH="/DDTX/dubbo/odn-service"
VERSION=$(date +"%Y%m%d-%H%M%S")
HISTORY_DIR=${LOCAL_PATH}/historyVersion
OPERATION=$3
USER=boco4a
IP=188.104.108.114

check(){
  # 查找对应的软件包
  if [ -f "${STORE_PATH}/${APPNAME}.tar.gz" ]; then
    echo "=========================================================="
    echo "待发布软件安装包未上传，请先上传                          "
    echo "=========================================================="
    exit 1
  fi
}
transport() {
  cd ${STORE_PATH} || exit 1
  echo "=========================================================="
  echo " 开始解压软件包................ "

  tar -xvf packager.tar.gz

  echo " 开始传输软件包................ "

  if [ ! -f "${STORE_PATH}/package/odnMainFrame.war" ]; then
    echo "=============================================="
    echo "缺少依赖包 odnMainFrame.war                   "
    echo "=============================================="
    exit 1
  fi
  echo " 开始部署 ......................"
    
  mv ${STORE_PATH}/${APPNAME}/odnMainFrame.war ${LOCAL_PATH}/

  rm -rf ${STORE_PATH}/${APPNAME}.tar.gz 
  tar -czvf ${APPNAME}.tar.gz ${APPNAME}

  scp "${STORE_PATH}/${APPNAME}.tar.gz" "boco4a@188.103.186.114:${REMOTE_PATH}"
}

stop() {
  jps -l | grep odnMainFrame | awk '{print $1}' | xargs kill -9
  ssh "${USER}@${IP}" "sh /DDTX/deploy/bin/run.sh stop" 
}

start() {
  cd ${LOCAL_PATH} || exit 1
  nohub java -jar 
}

backup(){
  # 备份
  HISTORY_VERSION=${HISTORY_DIR}/digitalBack_${VERSION}
  if [ ! -d "${HISTORY_VERSION}" ]; then
    make -p "${HISTORY_VERSION}"
  fi
  mv ${LOCAL_PATH}/odnMainFrame.war "${HISTORY_VERSION}"
}


if [ "${OPERATION}" == 'stop' ]; then 
  stop 
elif [ "${OPERATION}" == 'restart' ]; then
  stop
  start
  ssh "${USER}@${IP}" "sh /DDTX/deploy/bin/run.sh restart" 
elif [ "${OPERATION}" == "deploy" ]; then
  check
  transport
  stop
  backup
  start
else
  echo "=============================================="
  echo " 不支持的操作 ${OPERATION} "
  echo "=============================================="
  exit 1
fi
