#!/bin/sh

# xfs 是一种新的文件格式，可支持超大文件（单文件8tb, 大文件系统支持8eb）
# 支持热备份(xfsdump)与恢复(xfsrestore)。
# 
# -------------------------------------------------------------------------
# 备份
# -------------------------------------------------------------------------
# 1、进行分区的全量备份
# ---------------------
# xfsdump -f target_file(/opt/dbdump_v01)  source_path(/dev/sdb1) 
# -L sessionlable （交互的session 描述）
# -M medialable    (对于本次备份的资源描述)
# -s file_path     (对某个目录进行备份)--(这个目录路径是针对分区根目录的相对路径)
# ---------------------
# 2、恢复全量数据的备份
# ---------------------
# xfsrestore -f dumpfile(/opt/dbdump_v01)  restore_path(/data)
# -s file_path     (恢复某个文件夹)
# ---------------------------------------------------------------------------
# 3、增量数据备份
# ---------------------
# -l {1..9} 备份时根据参数 -l 指定 1-9 个级别(已经进行过全量备份的基础上)。
# xfsdump -l {1,,9} -f target_file(/opt/dbdump_v01)  source_path(/dev/sdb1) 
# ---------------------------------------------------------------------------
# 4、增量数据备份的恢复
# ---------------------
# 规则:
#  > 当同一个级别出现多次备份，恢复时候恢复最后一个即可
#  > 多个级别的备份需要在全量的基础上按照原来备份的顺序依次恢复
# 
# xfsrestore -f dumpfile(/opt/dumpfile_level_V01)  restore_path(/data) 
# ---------------------
# 注意事项
# ---------------------
# 1、被恢复的文件夹需要是空文件夹
# 2、不支持未挂载的文件系统的备份与恢复
# 3、需要root权限操作
# 4、


