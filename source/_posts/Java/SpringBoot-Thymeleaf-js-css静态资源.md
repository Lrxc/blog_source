---
title: SpringBoot-Thymeleaf-js-css静态资源
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


##环境及版本：
- Idea：2019.2
- springboot: 2.1.7.RELEASE

一 基本使用
1 引入pom.xml
```
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <!--thymeleaf-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
```
2 新建controller
```
    @RequestMapping("{page}")
    public String showPage(@PathVariable String page) {
        System.out.println(page);
        return page;
    }
```
3 resources目录下新建文件夹templates，然后新建index.html
```
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
i am index.html
</body>
</html>
```
4 总体目录结构
![image.png](https://upload-images.jianshu.io/upload_images/2803682-cc8ad33b5b3e2c96.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
浏览器输入 http://localhost:8080/index 即可看到内容
二 配合静态资源使用
1. resources目录下新建文件夹static，然后新建my.js
```
(function ($) {
    $.fn.alertObject = function () {
        alert('调用自定义js文件中的自定义方法');
    }
})(jQuery);
```
2. index.html 引入
```
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src="js/my.js"></script>
</head>
<body>
i am index.html
</body>
</html>
```
3 再次运行，就会有加载js了
直接访问http://localhost:8080/js/my.js 也能加载出js内容
三 thymeleaf自定义使用
1 thymeleaf访问格式
目前controller直接访问http://localhost:8080/index即可，那是因为thymeleaf默认的访问路径就是resources下的templates,而后缀默认.html 
源码如下：
![image.png](https://upload-images.jianshu.io/upload_images/2803682-be40f49b0ec63bdd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 修改thymeleaf的默认格式
templates下新建html文件夹，把index.html 放进去
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ea199242a6647f1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 新建application.yml
```
spring:
  #thymeleaf 自定义视图配置
  thymeleaf:
    prefix: classpath:/templates/html/
    suffix: .html
    #开发时关闭缓存,不然没法看到实时页面
    cache: false
    mode: HTML5
```
4. 再次运行,
偷偷告诉你们，suffix后缀直接修改为jsp，即可使用jsp格式了。。。网上thymeleaf使用jsp费了牛劲了。。。
http://localhost:8080/index
四 js 、css路径自定义
1 官方路径
上面新建static/js/my.js就可以正常引用，那就因为静态资源的加载路径默认有四个：
![image.png](https://upload-images.jianshu.io/upload_images/2803682-bcf96575797ac3e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 自定义
resources下新建custom/js，把my.js移动到下面
3 修改application.yml
```
spring:
  #静态资源访问格式 对比正常路径需要加上me  //http://localhost:8080/me/js/my.js
  mvc:
#    static-path-pattern: /me/**
  #自定义静态资源路径 //http://localhost:8080/js/my.js
  resources:
    static-locations: classpath:/custom/
```
4 访问http://localhost:8080/index即可
