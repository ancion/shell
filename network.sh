#!/usr/bin/env bash

:<<EOF

- ping 基于ICMP的简单通信协议,它通过计算 ICMP 发出的响应报文和 ICMP 发出的请求报文
之间的时间差来获得往返延迟时间,这个过程不需要特殊的认证，从而经常被很多网络攻击所利用，
如，端口扫描工具 nmap、分组工具 hping3 等。

EOF

ping Host

:<< EOF
-------------------------------------------------------------------------------
因此，为了避免这些问题，很多网络服务都会禁用 ICMP，
这使得我们无法使用 ping 来测试网络服务的可用性和往返延迟。
在这种情况下，您可以使用 traceroute 或 hping3 的 TCP 和 UDP 模式来获取网络延迟。

EOF

# hping3

# -c : request num 
# -S : set TCP SYN
# -p : set port to 80

hping3 -c 3 -S -p port baidu.com


# traceroute

# traceroute 会在路由的每一跳(hop)发送三个数据包，并在收到响应后输出往返延迟，如果没有响应
# 或者响应超时 （默认5s），将输出一个星号 * 。

# --tcp : 指定通信协议
# -p : z指定通信端口
# -n : 
traceroute --tcp -p 80 -n baidu.com


# telnet 
telnet Host port 

# 
# lsof : list open file (原意为显示打开的文件), 如果我们不加参数的时候，
# 就会显示所有的打开的文件，信息列主要是，什么命令打开，用户，文本类型等
#
# i [4|6][protocol][@hostname|hostaddr][:service|port]
# 
# -i : 指定打开的的 ip 协议, 默认是 `ipv4`, 如果需要 `ipv6` 指定 `-i6`
#   * `:port` 查看端口是否占用 
#   * `TCP|UDP` : 找到某种协议打开的文件
#   * `@hostname` : 找到某个域名打开的文件
# 
lsof -i :port


:<<EOF

- 获取tcp 请求的数据包, 然后使用抓包工具进行分析

EOF

tcpdump -nn -tcp port 8080 -w nginx.pcap



:<<EOF

wrk 并发请求测试

EOF

wrk --latency -c 100 -t 2 --timeout 2 http://192.168.64.103:8080

# 




