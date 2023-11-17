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
mkfs -t ext3|ext4|xfs /dev/vgname/lvname

# 挂载文件系统
mount -t xfs|ext3|ext4 -o defaults /dev/vgname/lvname  /mountpath


# ----------------------------------------------------------------------
# 直接将物理盘进行格式化，执行磁盘内文件系统的存储形式
mkfs -t xfs|ext4|ext3 /dev/sdb

# 挂载磁盘 直接挂载整个磁盘
mount -t xfs|ext3|ext4 -o defaults /dev/sdb mountpath


# 将磁盘的挂载信息写入到文件中

# 示例 (主要是六个部分)
#
# UUID=61c45d45-61a2-40d7-b27e-31e4050c1ff8 /                       ext4    defaults        1 1
#
# 第一部分, 磁盘的UUID (blkid 命令获取磁盘的 uuid 编号)
# 第二部分, 磁盘的挂载点 /data
# 第三部分, 磁盘内文件格式化类型, 例如 ext3, ext4, xfs, ntfs
# 第四部分, 文件系统参数()
#         > async/sync  是否为同步方式运行,默认为async
#         > auto/noauto 当运行 mount -a 的命令时,此文件系统是否被自动挂载,默认为auto
#         > rw / ro     是否以只读或者读写模式挂载
#         > exec/noexec 限制此文件系统内是否能够进行`执行`操作
#         > user/nouser 是否允许用户使用 mount 命令挂载
#         > suid/nosuid 是否允许 suid 存在
#         > Usrquota    启动文件系统支持磁盘配额模式
#         > Grpquota    地洞文件系统对群组磁盘配额模式的支持
#         > Defaults    同时具有rw,suid,dev,exec,auto,nouser,async 等默认参数的设置
# 第五部分, 能否被 dump 命令作用，  \
#          0 不要做dump 备份
#         > 1 每天进行 dump 操作
#         > 2 不定日期的进行
# 第六部分, 是否检验扇区
#         > 0 不要检验
#         > 1 最早检验(一般根目录会选择)
#         > 2 1 级别检验完成后进行检验


