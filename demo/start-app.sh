#!/bin/sh

start(){
    # 解压包裹
    unzip package.zip
    # 替换文件
    if [ -d package ]; then
        mv "./package/odn-utils-0.0.1-SNAPSHOT.jar" lib/
        mv "./package/odn-dubbo-interface-0.0.1-SNAPSHOT.jar" lib/
        mv ./package/odn-* ./
    fi
    # 删除文件夹
    if [ -d package ];then
        rm -rf ./package
    fi
    # 启动项目
    sh start-base.sh &>/dev/null \
           & sh start-eqp.sh &>/dev/null \
           & sh start-mq.sh  &>/dev/null \
           & sh start-order.sh
}

backup(){
    # 获取当前天数的备份文件夹名称
    BackUpDirName="./historyversion/"$(date +'%F')
    if [ -d "${BackUpDirName}" ]; then
        Cover=$BackUpDirName'-'$(date +"%H:%M:%S")
        echo ' 备份文件夹已存在,另存为:' "${Cover}"
        mv "${BackUpDirName}" "${Cover}"
    fi
    #echo "${BackUpDirName}"
    mkdir "${BackUpDirName}"
    # 真正的备份上一个版本项目的开始
    `ls -la` | grep "odn-"
    if [ $? -eq 0 ]; then
        mv odn-* "${BackUpDirName}/"
    fi
    `ls -la` lib/ | grep "odn-"
    if [ $? -eq 0 ]; then
        mv lib/odn-* "${BackUpDirName}/"
    fi
}

openlog(){

    Today=$(date +"%F")
    echo "${Chooselog}"
    case "${Chooselog}" in
        "1") 
            File="./logs/odn-equipment-service-${Today}.out"
            if [ -f "${File}" ];then
                tail -f "${File}"
            else
                echo "${File} 不存在, 请检查项目是否启动成功"
            fi
            ;;
        "2")
            File="./logs/odn-base-service-${Today}.out"
            if [ -f "${File}" ];then
                tail -f "${File}"
            else
                echo "${File} 不存在, 请检查项目是否启动成功"
            fi
            ;;
        "3")
            File="./logs/odn-order-service-${Today}.out"
            if [ -f "${File}" ];then
                tail -f "${File}"
            else
                echo "${File} 不存在, 请检查项目是否启动成功"
            fi
            ;;
        "4")
            File="./logs/odn-mq-listener-${Today}.out"
            if [ -f "${File}" ];then
                tail -f "${File}"
            else
                echo "${File} 不存在, 请检查项目是否启动成功"
            fi
            ;;
        * )
            echo " ------------------------------------------- "
            ;;
    esac

}

echo " -------------------------------------- "
echo " ========正在进行历史版本的备份======== "
echo " -------------------------------------- "
# 备份
backup
if [ "$?" -eq 0 ]; then
    echo " ==========>> 备份完成 << ========= "
else
    echo " =====>> 备份失败,启动终止 <<====== "
    return 1
fi
# 启动项目
echo " -------------------------------------- "
echo " ==========>> 正在启动项目 <<========== "
echo " -------------------------------------- "
start
sleep 2
echo " -------------------------------------- "
echo " ========>> 项目启动完成 << =========== "
echo " -------------------------------------- "
echo " "
# 查看日志
echo "1: odn-equipment-service-log"
echo "2: odn-base-service-log"
echo "3: odn-order-service-log"
echo "4: odn-mq-listener-log"
echo " "
echo " -------------------------------------- "
read -p "请输入日志对应的数字进行查看; 不查看日志,Enter健退出:" Chooselog
# 打开日志
openlog


