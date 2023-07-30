#!/usr/bin/env bash

:<< EOF

  rsync : 一个用于数据同步的命令，可以实现不同目录，不同服务器之间的数据同步
>---------------------------------------------------------------------------

基本使用:
  > 复制文件            
    + rsync file      new_file    复制单个文件(如果在当前文件夹需要指定新名称，如果到其他文件夹，未指定时使用源名称，指定了可以重命名)
    + rsync dir1/*    dir2/       复制目录下所有的文件(不包含子文件已经子文件夹内容)
  
  > 参数解释
    `-r`   递归复制文件夹以及子文件夹下的内容
    `-v`   显示复制时的详细信息
    `-u`   复制时只对修改过的文件进行复制(包括新建的和修改过的)

  > 远程服务器复制
    + 当我们需要与远端服务器进行文件同步的时候，根据需求，可以在源，或者目标文件之前指定服务器的信息
      例如 `rsync dir1/*   root@192.168.180.11:/home/unicorn/dir2/

  > 断点续传 (rsync 的默认行为是先复制到临时文件夹，复制完成后移动到目标位置)
    + `--inplace` : 改变默认行为，直接将文件复制到目标位置,
    + `--partial` : 保留传输过程中生成的中间态文件(传输了一半的文件，不删除)
    + `--append`  : 在开启一个传输的时候，如果检测到了未传输完成的文件，继续向里面追加，而不是从头开始同步
       - 使用这个参数的时候,相同于使用了 `--inplace, --partial` 的基础上实现了文件的追加
    + `--append-verify` : 新版本中添加的，与 `--append` 大部分意义与`--append`一致，
       - 但是在传输完成的时候会 `checksum` 保证传输的文件与源文件的`MD5`值是一致的，
       - 如果不一致，则认为传输过程中出现了异常，失败了，删除后重新传输 
       - 由于存在比对过程会增加耗时, 如果是远程的服务器，还有通信过程之间的耗时

  > 一些显示进度的参数
    + `--progress` : 显示同步过程的进度（百分比）
    + `--bwlimit=30000` : 限制传输的速度, 默认单位是`kb`

  > 预运行
    + `--dry-run` : 可以显示命令运行后会产生的影响(有多少文件被复制,与 `-v` 参数一起使用可以显示具体哪些文件将被操作), 但是命令不会真的执行.
    
  > 备份文件的需求
    + `--archive`: 这个指令是一系列指令的组合(`-rlptgoD`) 实现整个文件以及文件夹的复制的时候，保留更多的文件原始信息
      - 文件的修改时间,
      - 文件的所有者,
      - 文件的的权限,
      - 如果是软连接也会保留连接，不会复制软连接指向的文件
 
:EOF