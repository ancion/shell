######################################################################
#  此 脚本用于 76 上分发前端项目，并调用目标服务器上的脚本解压部署
#
STORE_PATH=/DDTX/deploy/store
APPNAME=$1
ENRIRON=$2
REMOTE_PATH="/DDTX"


# 发布的软件需要限制
if [ ! "${APPNAME}" == 'digitalApp' ] && [ ! "${APPNAME}"  == "digitalWeb" ]; then
  echo "=========================================================="
  echo "   未定义的软件 : ${APPNAME}                              "
  echo "=========================================================="
  exit 1
fi

# 查找对应的软件包
if [ -f "${STORE_PATH}/${APPNAME}.tar.gz" ]; then
  echo "=========================================================="
  echo "待发布软件安装包未上传，请先上传                          "
  echo "=========================================================="
  exit 1
fi

echo "=========================================================="
echo " 开始传输软件包................ "

scp "${STORE_PATH}/${APPNAME}.tar.gz" "boco4a@188.103.186.75:${REMOTE_PATH}"
echo " 开始部署 ......................"
ssh boco4a@188.103.186.75 "sh /DDTX/deploy/bin/run.sh ${APPNAME} ${ENRIRON}" 