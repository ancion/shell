#!/bin/bash

:<<!
---------------------------------------------------------------
1、背景：新购买的服务器需要初始化 linux 系统
--------------------------------------------
1. 设置时区并同步时间
2. 禁用 selinux
3. 清空防火墙策略，设置自己的策略
4. 历史命令显示操作时间
5. 设置 SSH 登录超时时间
6. 禁止 root 用户远程登录
7. 禁止定时任务向root 用户发送邮件(占用空间)
8. 提高最大可打开的文件数量
9. 系统内核的优化
10. 减少 swap 分区的使用 
11. 安装系统性能分析工具
---------------------------------------------
!

# 设置时区时间并定时同步
ls -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
if ! crontab -l | grep ntpdata &>/dev/null; then 
  (echo "* 1 * * * ntpdate time.windows.com >/dev/null 2>&1"; crontab -l) | crontab 
fi

# 禁用selinux 
 sed -i '/SELINUX/{s/permissive/disabled/}' /etc/selinux/config

# 关闭防火墙
if egrep "7.[0-9]" /etc/redhat-release &>/dev/null; then 
  systemctl stop firewalld
  systemctl disable firewalld
elif egrep "6.[0-9]" /etc/redhat-release &>/dev/null; then
  service iptables stop 
  chkconfig iptables off
fi

# 历史命令添加操作时间
if ！grep HISTTIMEFORMAT /etc/bashrc; then 
  echo 'export HISTTIMEFORMAT="%F %T `whoami` "' >> /etc/bashrc
fi

# SSH 超时时间
if ！grep "TMOUT=600" /etc/profile &>/dev/null; then
  echo "export TMOUT=600" /etc/profile
fi

# 禁止 root 用户远程登录
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 禁止定时任务向用户发送邮件
sed -i 's/^MAILTO=root/MAILTO=""/' /etc/crontab

# 设置最大可打开的文件数量
if ！grep "* soft nofile 65535" /etc/security/limits.conf &>/dev/null; then 
  cat >> /etc/security/limits.conf << EOF
  * soft nofile 65535 
  * hard nofile 65535
EOF
fi

# 系统内核优化
cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_tw_buckets = 20480
net.ipv4.tcp_max_syn_backlog = 20480
net.core.netdev_max_backlog = 262144
net.ipv4.tcp_fin_timeout = 20
EOF

# 减少swap 使用
echo "0" > /proc/sys/vm/swappiness

# 安装一些性能分析工具
yum install gcc make autoconf vim sysstat net-tools iostat iftop iotp lrzz -y 




