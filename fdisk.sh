#!/bin/bash

fdisk
# -l 列出所有磁盘


# 磁盘编
# -----------------------------------
# /dev/sda(第一块磁盘) --- /dev/sda{0..9} (一块磁盘下的多个分区)

# 分区
sudo fdisk /dev/sda

# 管理员权限执行磁盘操作。
# 提供一组命令进行操作
# -p 打印分区信息
# -m 获取帮助菜单
# -n 构建一个新的分区
# -w 写入分区信息
# ......

# 创建分区之后,需要创建物理卷
pvcreate /dev/sda1

# 查看创建的物理卷
pvdisplay

# 创建一个新的卷组
vgcreate vgname /dev/sda1

# 查看卷组
vgdisplay

# 创建一个新的逻辑卷 并将卷组空间全部分配给该逻辑卷
lvcreate -l +100%FREE vgname

# 查看逻辑卷
lvdisplay

# 格式化文件系统
mkfs.ext3|.ext4|.xfs /dev/vgname/lvname

# 挂载文件系统
mount -t xfs|ext3|ext4 -o defaults /dev/vgname/lvname  /mountpath


# ----------------------------------------------------------------------
# 直接将物理盘进行格式化，执行磁盘内文件系统的存储形式
mkfs -t xfs|ext4|ext3 /dev/sdb

# 挂载磁盘 直接挂载整个磁盘
mount -t xfs|ext3|ext4 -o defaults /dev/sdb mountpath


