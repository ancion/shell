#!/bin/bash

:<<!
-------------------------------------------------------------------
 linux 发送邮件,内部的邮件服务,延迟大,会被其他邮箱识别为垃圾邮件
------------------
安装外部的邮件发送服务
yum install mailx
------------------
安装好之后会配置文件在 /etc/mail.rc 
在配置的末尾添加几行配置,主要配置一些用户信息

set from=baojingtongzhi@163.com smtp=smtp.163.com
set smtp-auth-user=baojingtongzhi@163.com smtp-auth-password=unicorn123
set smtp-auth=login

!

echo "this is a test demo" | mail -s "monitor" 2471855439@qq.com
