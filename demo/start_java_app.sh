#!/bin/bash

:<<!
------------------------------------------------------------------
直接使用 git 拉取代码, 并进行构建、备份、发布
------------------------------------------------------------------
基础环境:
    - jdk
    - maven
    - tomcat
    - git
    - unzip
!

DATE=$(date +"%F_%T")
TOMCAT_NAME=$1
TOMCAT_DIR=/usr/local/${TOMCAT_NAME}
ROOT=${TOMCAT_DIR}/webapps/ROOT

# 文件备份的目录
BACKUP_DIR=/data/tomcat/backup
# 项目拉取临时构建的目录
WORK_DIR=/tmp
# 项目名称
PROJECT_NAME=tomcat-java-demo


# 拉取项目
cd ${WORK_DIR} || exit
if [ ! -d $PROJECT_NAME ]; then
    git clone https://www.github.com/ancion/tomcat-java-demo
    cd "${PROJECT_NAME}" || exit
else
    cd "${PROJECT_NAME}" || exit
    git pull
fi

# 构建
mvn clean package -Dmaven.test.skip=true

if [ $? -ne 0 ]; then 
    echo "maven build failure!!"
    exit 1
fi

# 备份
TOMCAT_PID=$(ps -ef | grep "${TOMCAT_NAME}" | egrep -v "grep | $$" | awk 'NR==1{print $2}')
[ -n "${TOMCAT_PID}" ] && kill -9 "${TOMCAT_PID}"
[ -d "$ROOT" ] && mv "$ROOT" "${BACKUP_DIR}"/"${TOMCAT_NAME}"_ROOT"${DATE}"

# 部署
unzip ${WORK_DIR}/${PROJECT_NAME}/target/*.war -d "${ROOT}"
"${TOMCAT_DIR}"/bin/startup.sh




