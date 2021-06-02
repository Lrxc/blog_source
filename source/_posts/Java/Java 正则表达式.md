---
title: Java 正则表达式
date: 2021-05-01 10:01:33
categories: 
- java
tags: [java]
---

<meta name="referrer" content="no-referrer" />

String使用

```
/**
* 正则表达式
* . 匹配除"\r\n"之外的任何单个字符。若要匹配包括"\r\n"在内的任意字符，请使用诸如"[\s\S]"之类的模式
* * 匹配除"\r\n"之外的任何单个字符。若要匹配包括"\r\n"在内的任意字符，请使用诸如"[\s\S]"之类的模式
* () 匹配 pattern 并捕获该匹配的子表达式
*/
String regex = "/api/(.*)";

String url1 = "/api/login";
String url2 = "/doc/login";

System.out.println(url1.matches(regex));//true
System.out.println(url2.matches(regex));//false
```

