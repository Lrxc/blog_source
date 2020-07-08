---
title: Spring-常用注解说明
date: 2018-07-01 16:01:33
categories: Spring
tags: spring
---

<meta name="referrer" content="no-referrer" />


@RequestBody这个一般处理的是在ajax请求中声明contentType: "application/json; charset=utf-8"时候。也就是json数据或者xml(我没用过这个，用的是json)

@RequestParam这个一般就是在ajax里面没有声明contentType的时候，为默认的。。。urlencode格式时，用这个。
