#!/bin/bash

:<<!
-------------------------------------------------------
假定 nginx 日志格式：
$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"

!

# 将调用脚本的第一个参数作为待分析的日志文件
LOG_FILE=$1

top_10_ip(){
    echo "统计访问最多的10个ip==>>"
    awk '{OFS="\t"}
    {
        a[$1]++
    }
    END {
        print "UV: ", length(a);
        for (v in a){
            print a[v], v
        }
    }' "${LOG_FILE}" | sort -k 1 -nr | head -10
}

# 获取某时段内的访问最多的 ip Top10
time_range_top_10_ip(){
    echo "统计某个时段访问最多的10个ip==>>"
    awk '{OFS="\t"}
    $4>="[02/Sep/2019:12:00:00" && $4<="[10/Sep/2020:12:00:00"{
        a[$1]++
    }
    END {
        for(v in a){
            print a[v], v
        }
    }' "${LOG_FILE}" | sort -k 1 -nr | head -10
}

top_10_page(){
    echo "访问超过100次的页面 ==>>"
    awk '{OFS="\t"}
    {
        a[$7]++
    }j
    END{
        print "PV: ",length(a);
        for(v in a) {
            if (a[v] > 50){
                print a[v], v
            }
        }
    }' "${LOG_FILE}" | sort -k 1 -nr
}


# 访问的状态码统计
status_code_statistic(){
    awk '{OFS="\t"}
    {
        a[$7" "$9]++
    }
    END {
        for(v in a){
            if (a[v] > 5) {
                print a[v], v
            }
        }

    }' "${LOG_FILE}" | sort -k 1 -nr
}



# top_10_ip
# time_ranme_top_10_ip
# top_10_page
status_code_statistic
