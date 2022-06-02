#!/bin/bash



#!/bin/bash
# stream tool cut
#  -d  the separation of cut
#  -f  the index of divition,the separation as a index
ip address | grep eth0 | cut -d " " -f 3
#  -c  specify the charactor position
ip address | grep eth0 | cut -c 2,3,4,5,6,7,8,8,8,8
ip address | grep eth0 | cut -c 2-8  # 截取 2-8 字符
ip address | grep eth0 | cut -c -8   # 从开始位置截取到8
ip address | grep eth0 | cut -c 2-   # 从2截取到最后
