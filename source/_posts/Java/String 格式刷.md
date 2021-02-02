---
title: String 格式刷
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />



### 格式刷

    //这样1就输出01，前面自动补0, 11还是输出11不变    
    System.out.println(String.format("%02d",x)); //x是你要输出的整数
    //“%02d”是指定输出格式，%作先导标记，0表示自动补0, 2的意思是最小长度为2（如果用4，则1输出0001），d表示整数。
    
    
    String s=String.format("%.2f",d)表示小数点后任意两位小数
    
    //
    String str=String.format("%d-%02d-%02d", mYear, mMonth, mDay)