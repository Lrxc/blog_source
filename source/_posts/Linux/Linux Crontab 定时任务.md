---
title: Linux Crontab 定时任务
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />




## 环境及版本

- Linux: Ubuntu 18.0.4
- 

## 基本命令

1. 格式

   ```shell
   crontab -l		显示所有定时任务
   crontab -e		编辑定时任务
   crontab -r		删除所有定时任务
   ```

2. 语法

   我们用**crontab -e**进入当前用户的工作表编辑，是常见的vim界面。每行是一条命令

   crontab的命令构成为 时间+动作，其时间有**分、时、日、月、周**五种

   ```shell
   #每隔一分钟执行一次
   * * * * * xxx.sh
   #每年1月1日 1时1分 执行
   1 1 1 1 * xxx.sh
   ```

## 新建测试

1. 新建测试脚本

   ```sh
   #vim /root/test.sh
   echo 'hello' >> /root/info.log
   ```

2. 赋权

   ```shell
   chmod 777 test.sh
   ```

3. 新建定时任务

   ```sh
   #crontab- e
   * * * * * /root/run.sh  #每分钟执行一次
   ```

4. 查看效果

   ```shell
   //实时查看日志
   tail -f /root/info.log
   //每隔一分钟打印一遍
   ```

   