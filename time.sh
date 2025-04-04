#!/bin/bash

# 修改系统时间
# date -s "2021-12-17 11:11:11"

# ntp 软件没有的话需要安装
# yum install ntp -y 

# 同步网络时间
# ntpdate time.windows.com

# 获取主机时间
# date +%Y-%m-%d-%H:%M:%S

# -----------------------------------------------------------------
# 在局域网中保持所有机器与某一台机器同步，保证在局域网内的时间一致性
# service ntpd start
# 其他机器将向开启这个服务的机器进行时间同步

# -----------------------------------------------------------------
# 配置文件
# /etc/ntp.conf


## 开启系统时间自动同步的
# systemctl start ntpdate
# systemctl enable ntpdate
# systemctl status ntpdate
