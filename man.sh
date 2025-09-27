#!/usr/bin/bash

## Linux 系统编程经常需要用到 man 命令 

## sudo pacman -S man-pages 

## 使用方式，查看 man 命令的用法
## man 的级别 
## man -l 查看 man 命令支持的级别

# 1   Executable programs or shell commands   # 用户命令
# 2   System calls (functions provided by the kernel)  # 系统接口
# 3   Library calls (functions within program libraries)  # 库函数
# 4   Special files (usually found in /dev)   # 特殊文件(比如设备文件)
# 5   File formats and conventions, e.g. /etc/passwd  # 文件
# 6   Games  # 游戏
# 7   Miscellaneous (including macro packages and conventions), e.g. man(7), groff(7), man-pages(7)  # 系统的软件包
# 8   System administration commands (usually only for root)  # 系统管理命令
# 9   Kernel routines [Non standard] # 内核


## man -k 查看 man 命令支持的关键字 

