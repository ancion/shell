###################################################################################
# 此脚本用于发布前端项目 
# 可接受两个参数，第一个为项目名称，第二个为发布环境
# 例如 : run.sh digitalApp preview
# 例如 : run.sh digitalWeb preview
# 例如 : run.sh digitalApp prod
# 例如 : run.sh digitalWeb prod
###################################################################################

BASE_DIR=/DDTX
VERSION=$(date +"%Y%m%d-%H%M%S") 
HISTORY_DIR=${BASE_DIR}/historyVersion/
# 当前发布软件的名称
APPNAME=$1
# 当前需要发布的环境
ENVIRON=$2
deploypreview(){
    BASE_DIR=${BASE_DIR}/preview
    if [ "${APPNAME}" == 'digitalWeb' ];then
        APPNAME=digitalpreWeb
    elif [ "${APPNAME}" == 'digitalApp' ];then 
        APPNAME=digitalpreApp
    fi
    deployprod
}
deployprod() {
    cd ${BASE_DIR} || exit 1
    if [ ! -f "${BASE_DIR}/${APPNAME}.tar.gz" ]; then 
        echo " ===================================================================="
        echo " 未找到软件包，请先上传软件包  "
        echo " ===================================================================="
        exit 1
    fi
    sleep 1
    # 备份
    if [ ! -d ${HISTORY_DIR} ]; then 
        mkdir -p ${HISTORY_DIR}
    fi
    mv "${BASE_DIR}/${APPNAME}" "${HISTORY_DIR}/${APPNAME}_${VERSION}"
    # 解压
    tar -xvf  "${APPNAME}.tar.gz"
    # 删除压缩包
    rm -rf "${APPNAME}.tar.gz"
    sleep 1
    echo " ===================================================================="
    echo " 发布完成, 请登录到网站查看效果 "
    echo " ===================================================================="
}
echo " ===================================================================="
echo " 发布软件 :: ${APPNAME}  ----- 发布环境 :: ${ENVIRON}    "
echo " ===================================================================="

# 校验软件
if [ ! "${APPNAME}" == 'digitalWeb' ] && [ ! "${APPNAME}" == 'digitalApp' ]; then 
    echo " ===================================================================="
    echo "未定义的软件信息 ${APPNAME} "
    echo " ===================================================================="
    exit 1
fi
# 校验环境
if [ "${ENVIRON}" == 'prod' ]; then 
    deployprod    
elif [ "${ENVIRON}" == 'preview' ]; then
    deploypreview
else 
    echo "未定义的发布环境参数 :: ${ENVIRON} " 
    echo "===========>> 发布失败 <<=========="
    exit 1
fi
