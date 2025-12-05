#!/usr/bin/env bash 

: <<'EOF'

curl 命令的使用 ::

- URL 访问某个地址，默认使用的是 GET 请求

--------------------------------------------------------------------
1. HTTP 协议

-X -[POST|GET|DELETE|PUT]  请求方式
-d ['key=value&key=value']  请求参数
-d '{"name": "alex", "age": 18}' 请求参数
-H 'key: value' 请求头 (可以写多个)
-H "Content-Type: application/json" 请求头
-I 显示响应头
--------------------------------------------------------------------
文件操作
-O 将文件下载到本地，默认下载到当前目录
-o [newFileName] 指定下载后的文件名，（将服务器上下载的文件重命名了）
-C - 断点续传(意外终止可以继续下载)
--limit-rate 1024k  限制下载速度,不设置单位默认是字节

curl -sSL -C - -o nginx.tar.gz  https://nginx.org/download/nginx-1.24.0.tar.gz

--------------------------------------------------------------------
-L 跟随重定向
-v 显示详细信息
--------------------------------------------------------------------

代理访问目标地址
curl --proxy $协议://$username:password@$proxyIP:$port $URL


2. ftp 协议

-u username:password  认证用户名和密码
-O 下载文件
-o [newFileName]下载文件并重命名
-T [fileName] 当前文件夹中上传文件

curl -u user:password -T nginx.conf ftp://server.com/xxxx


EOF


