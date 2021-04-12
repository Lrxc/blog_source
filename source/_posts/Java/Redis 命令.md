---
title: Redis 命令
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


redis常用命令

```
redis> keys * 				#查看所有key
redis> set keyname keyvalue	#设置key和value
redis> get keyname  		#根据key获取value

redis> expire keyname 30	# 设置过期时间为 30 秒
(integer) 1
redis> ttl keyname			# 查看剩余过期时间
(integer) 23
```

