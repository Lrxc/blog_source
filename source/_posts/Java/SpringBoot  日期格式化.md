---
title: SpringBoot  日期格式化
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


#　Springboot 日期格式化

1 DateTimeFormat 将String转换成Date

- 前端给后端传值时用,参数为param时

  ```
  @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private Date date;
  ```

2 JsonFormat 将Date转换成String

- 前端给后端传值时用,参数为json时

- 后端返回给前端时 

- 数据库获取时间类型映射实体类

  ```
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
  private Date testTime;
  ```

3 实在不行两个都加上