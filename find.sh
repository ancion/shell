:<<!

find [path] [options] [excution]

- [path] 路径 -- 需要查找的路径

- [options] 可选参数 -- 选项

  -name -- 指定文件名
    -'*.java' (可以使用统配符号)
  -perm -- 指定文件权限
    -'0755' 
  -user -- 指定文件所有者
    -'root'
  -group -- 指定文件所属组
    -'root'
  -type -- 查找文件的类型
     -f -- 查找普通文件
     -d -- 查找目录
     -c -- 查找字符设备文件
     -b -- 查找块设备文件
     -p -- 查找命名管道文件
     -l -- 查找符号链接文件
  -size -- 查找文件的大小
     `-n` (小于) b(默认) c(单字节) w(双字节) k(Kb) M(Mb) G(Gb) T(Tb)
     `+n` (大于)
     ` n` (等于)
  -mtime -- 查找文件的修改时间
     `-n` (多少天之内有修改)
     `+n` (多少天之前有修改)
     ` n` (前多少天修改)
  -mmin -- 查找文件的修改时间
     `-n` (多少分钟之内有修改)
     `+n` (多少分钟之前有修改)
     ` n` (前多少分钟修改)
  -mindepth -- 开始查找的最小深度
     ` n` (从第几级子目录开始搜索)
  -maxdepth -- 查找的最大深度
     ` n` (最多向下搜索几级子目录)
- [excution] 可选参数 -- 执行命令
  
  -print -- 打印结果(默认输出)
  -exec  -- 执行命令 格式：`-exec command {} \`
!


# 将 /var/log 中以 .log 结尾的文件，且修改时间在7天之前的文件，删除
find /var/log -name '*.log'  -mtime +7 -exec rm -f {} \;


# 搜索`/etc`下的文件（非目录）,文件名以 `.conf` 结尾的文件,文件大于 1K,将这些文件复制到 /root/conf
find /etc -type -f -name '*.conf' -size +1k -mtime -1 -exec cp {} /tmp/conf \;
