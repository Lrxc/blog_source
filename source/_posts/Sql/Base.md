---
title: Base
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

