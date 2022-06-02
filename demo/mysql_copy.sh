#!/bin/bash


:<<!
--------------------------------------------------------
以数据库为基本级别与单位进行mysql的数据备份:
    1. 使用 mysql 提供的面交互的查询数据库的脚本命令.
       找到需要进行备份的数据库(需要排除mysql数据库本来的库)
    2. 将数据库按照一定的规则备份到指定的文件夹中
--------------------------------------------------------
!
backup_on_db(){
    DATE=$(date +"%F_%H-%M-%S")
    HOST='localhost'
    USER=backup  # 一般做备份的用户权限较小，只有查询权限，没有删改的权限
    PASS='123@local'
    BACKUP_DIR=/data/db_backup
    # 获取需要做备份的数据库的名称
    # -----------------------
    # mysql 下的几个命令参数
    # -----------------------
    # -e 免交互的输出
    # -s 去除控制台打印时候产生的边框间隔线
    # -----------------------
    # mysqldump 下的几个命令参数
    # -----------------------
    # -B 指定数据库的名称
    DB_LIST=$(mysql -h${HOST} -u${USER} -p${PASS} -s -e "show databases;" 2>/dev/null | \
                    grep -E -v "Database|information_schema|mysql|performance_schema|sys")

    for DB in $DB_LIST; do
        BACKUP_NAME=${BACKUP_DIR}/${DB}_${DATE}.sql
        if ! mysqldump -h${HOST} -u${USER} -p${PASS} -B $DB > ${BACKUP_NAME} 2>/dev/null; then
            # 正常这里需要发送邮件给管理员或者运维的, 测试用例就使用打印的方式代替
            echo "${DB} backup failured !!!!"
        fi
    done
}

:<<!
--------------------------------------------------------
以数据库为基本级别与单位进行mysql的数据备份:
    1. 使用 mysql 提供的面交互的查询数据库的脚本命令.
       找到需要进行备份的数据库(需要排除mysql数据库本来的库)
    2. 将每个数据库按照一定的规则创建一个文件夹，将数据库中
       表按照一定的命名规则备份到对应的库文件夹中
--------------------------------------------------------
!
backup_on_table(){
    DATE=$(date +"%F_%H-%M-%S")
    HOST='localhost'
    USER=backup  # 一般做备份的用户权限较小，只有查询权限，没有删改的权限
    PASS='123@local'
    BACKUP_DIR=/data/db_backup
    # 获取需要做备份的数据库的名称
    # -----------------------
    # mysql 下的几个命令参数
    # -----------------------
    # -e 免交互的输出
    # -s 去除控制台打印时候产生的边框间隔线

    # -----------------------
    # mysqldump 下的几个命令参数
    # -----------------------
    # -B 指定数据库的名称
    DB_LIST=$(mysql -h${HOST} -u${USER} -p${PASS} -s -e "show databases;" 2>/dev/null | \
                    grep -E -v "Database|information_schema|mysql|performance_schema|sys")

    for DB in $DB_LIST; do
        BACKUP_DB_DIR=${BACKUP_DIR}/${DB}_${DATE}
        [ ! -d ${BACKUP_DB_DIR} ] && mkdir -p ${BACKUP_DB_DIR} &>/dev/null
        # 获取每个 DB 下的所有表
        TABLE_LIST=$(mysql -h${HOST} -u${USER} -p${PASS} -s -e "use ${DB}; show tables;" 2>/dev/null)
        for TABLE in $TABLE_LIST; do
            BACKUP_NAME=${BACKUP_DB_DIR}/${TABLE}.sql
            if ! mysqldump -h${HOST} -u${USER} -p${PASS} ${DB} ${TABLE} > ${BACKUP_NAME} 2>/dev/null; then
                # 正常这里需要发送邮件给管理员或者运维的, 测试用例就使用打印的方式代替
                echo "${DB}_${TABLE} backup failured !!!!"
            fi
        done
    done
}
