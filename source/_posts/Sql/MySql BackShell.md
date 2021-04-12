---
title: MySql BackShell
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


#### 1. 检查是log_bin是否开启

增量备份需要开启log_bin
若状态为`on` 则是已经开启log_bin

	mysql> show variables like '%log_bin%';
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| log_bin                         | OFF   |
	| log_bin_basename                |       |
	| log_bin_index                   |       |
	| log_bin_trust_function_creators | OFF   |
	| log_bin_use_v1_row_events       | OFF   |
	| sql_log_bin                     | ON    |
	+---------------------------------+-------+
	6 rows in set (0.11 sec)

若没开启log_bin，则修改mysql配置文件my.cnf，添加以下配置，重启mysql使配置生效

```
log-bin=/var/lib/mysql/mysql-bin
```

查看当前正在记录操作的日志log_bin文件名称

```
mysql > show master status;
```

#### 2.  全量备份

只要执行下述命令，就可以进行全量备份

	mysqldump -uroot -p123456 --quick --events --all-databases --flush-logs --delete-master-logs --single-transaction > data.sql

全量备份脚本 MsyqlFullBack.sh

```
#!/bin/bash
# 初始化时，创建相应目录
# mkdir -p /home/mysql/backup/daily 

# 定时任务
# 每个星期日凌晨3:00执行全量备份脚本 
# 0 3 * * 0 /bin/bash -x /root/mysqlFullBack.sh >/dev/null 2>&1
# 周一到周六凌晨3:00执行增量备份脚本
# 0 3 * * 1-6 /bin/bash -x /root/mysqlPartBack.sh >/dev/null 2>&1

BakDir=/home/mysql/backup
LogFile=/home/mysql/backup/bak.log
Date=`date +%Y%m%d`
Begin=`date +"%Y年%m月%d日 %H:%M:%S"`
cd $BakDir
DumpFile=$Date.sql
GZDumpFile=$Date.sql.tgz
mysqldump -uroot -p123456 --quick --events --all-databases --flush-logs --delete-master-logs --single-transaction > $DumpFile
/bin/tar -zvcf $GZDumpFile $DumpFile
/bin/rm $DumpFile
Last=`date +"%Y年%m月%d日 %H:%M:%S"`
echo [FullBack] 开始:$Begin 结束:$Last $GZDumpFile successful >> $LogFile
# scp重复全量备份文件到其他服务器
# scp $GZDumpFile root@xxxx:/usr/mysql/backup/$GZDumpFile
# 删除30天前的全量备份文件
find $BakDir -mtime +30 -type f -name "*.sql.tgz" | xargs rm -f
# 删除增量备份文件
cd $BakDir/daily
/bin/rm -f *
```

#### 3.  增量备份

只要执行下述命令，就会生成相应的增量备份日志，根据日志可以恢复增量备份

在/var/lib/mysql下或/var/lib/mysql/mysql-bin下可查看到增量备份日志

```
mysqladmin -uroot -p123456 flush-logs
```

增量备份脚本 MysqlPartBack.sh

```
#!/bin/bash
#在使用之前，请提前创建以下各个目录
backupDir=/home/mysql/backup/daily
#增量备份时复制mysql-bin.00000*的目标目录，提前手动创建这个目录
mysqlDir=/var/lib/mysql
#mysql的数据目录
logFile=/home/mysql/backup/bak.log
BinFile=/var/lib/mysql/binlog.index
#mysql的index文件路径，放在数据目录下的

mysqladmin -uroot -p123456 flush-logs
#这个是用于产生新的mysql-bin.00000*文件
# wc -l 统计行数
# awk 简单来说awk就是把文件逐行的读入，以空格为默认分隔符将每行切片，切开的部分再进行各种分析处理。
Counter=`wc -l $BinFile |awk '{print $1}'`
NextNum=0
#这个for循环用于比对$Counter,$NextNum这两个值来确定文件是不是存在或最新的
for file in `cat $BinFile`
do
    base=`basename $file`
    echo $base
    #basename用于截取mysql-bin.00000*文件名，去掉./mysql-bin.000005前面的./
    NextNum=`expr $NextNum + 1`
    if [ $NextNum -eq $Counter ]
    then
        echo $base skip! >> $logFile
    else
        dest=$backupDir/$base
        if(test -e $dest)
        #test -e用于检测目标文件是否存在，存在就写exist!到$logFile去
        then
            echo $base exist! >> $logFile
        else
            cp $mysqlDir/$base $backupDir
            echo $base copying >> $logFile
         fi
     fi
done
echo [PartBack] `date +"%Y年%m月%d日 %H:%M:%S"` $Next Bakup successful! >> $logFile
```

