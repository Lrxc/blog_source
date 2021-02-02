---
title: MySql 常用命令
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


## 常用命令

1. 当前mysql任务列表

```
mysql> show processlist		#，比如导入数据卡住查看
```

2. max_allowed_packet 限制

```
//查询已有的
show variables like '%max_allowed_packet%';
//设置新的
set global max_allowed_packet = 2*1024*1024*10;
```

3. 查看占用空间

   ```
   USE information_schema;
   SELECT TABLE_SCHEMA, SUM(DATA_LENGTH) FROM TABLES GROUP BY TABLE_SCHEMA;
   ```

   可看到各个数据库的所占空间大小，如果想要看到以`k`为单位的大小，代码如下

   ```
   USE information_schema;
   SELECT TABLE_SCHEMA, SUM(DATA_LENGTH)/1024 FROM TABLES GROUP BY TABLE_SCHEMA;
   ```

   **就是字节数除以1024**，同理，`M`和`G`分别是再除一个1024和再除两个1024.