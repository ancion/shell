
:<<!
---------------------------------------
# 生成密钥对
# -t  指定密钥类型
# -b  指定密钥长度
# -P  指定密钥密码
# -f  指定密钥文件存放的地址
ssh-keygen -t rsa -b 4096 -P '' -f ~/.ssh/id_rsa

# 将公钥发送给免密登录的服务器, 并将公钥添加到服务器的authorized_keys文件中
# 该命令传递公钥到服务器并自动添加到服务器的~/.ssh/authorized_keys文件中

# -i  指定公钥文件
# -p  指定ss登录的服务器的端口
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 22 root@192.168.64.136


# 设置了免密登录的时候希望可以使用主机名来登录
# 在服务器的/etc/ssh/ssh_config文件中添加如下内容

# 严格主机校验关闭
StrictHostKeyChecking no
# 未知的主机信息的输出被忽略
UserKnownHostsFile /dev/null


!
