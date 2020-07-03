---
title: Spring-常见问题汇总
date: 2018-07-01 16:01:33
categories: Spring
tags: spring
---


1 异常：org.apache.ibatis.binding.BindingException
原因：maven项目中 静态资源打包被拦截
解决：pom.xml build中添加
```
<!-- 放行静态资源 -->
<resources>
	<resource>
		<directory>src/main/java</directory>
		<includes>
			<include>**/*.xml</include>
		</includes>
	</resource>
	<resource>
		<directory>src/main/resources</directory>
		<includes>
			<include>**/*.xml</include>
			<include>**/*.properties</include>
		</includes>
	</resource>
</resources>
```
