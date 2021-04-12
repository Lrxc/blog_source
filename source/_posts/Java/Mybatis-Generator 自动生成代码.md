---
title: Mybatis-Generator 自动生成代码
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


##环境及版本：

- mybatis-generator：mybatis-generator-core-1.4.0-bundle.zip
- jdk: 1.8



# 一 命令直接使用

 ##　1. 下载mybatis-generator

官网：https://github.com/mybatis/generator/releases

##　2. 下载数据库连接驱动

**数据库驱动和mybatis-generator放在同一路径下**

```shell
# mysql下载地址,下载mysql-connector-java-5.1.49.tar.gz
https://dev.mysql.com/downloads/connector/j/5.1.html
```
```shell
# oracle下载地址,下载ojdbc6.jar
https://www.oracle.com/database/technologies/jdbcdriver-ucp-downloads.html
```
![image-20200814193235582.png](https://upload-images.jianshu.io/upload_images/2803682-4bb124d645a92f98.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 3. 编写generatorConfig.xml文件

```properties
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <!--数据库驱动-->
    <classPathEntry    location="ojdbc6.jar"/>
    <context id="DB2Tables"    targetRuntime="MyBatis3">
        <commentGenerator>
            <property name="suppressDate" value="true"/>
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>
        <!--数据库链接地址账号密码-->
        <jdbcConnection driverClass="oracle.jdbc.driver.OracleDriver" connectionURL="jdbc:oracle:thin:@10.10.98.200:1521/test" userId="123" password="123">
        </jdbcConnection>
        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>
        <!--生成Model类存放位置-->
        <javaModelGenerator targetPackage="com.model" targetProject="src">
            <property name="enableSubPackages" value="true"/>
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>
        <!--生成映射文件存放位置-->
        <sqlMapGenerator targetPackage="com.mapping" targetProject="src">
            <property name="enableSubPackages" value="true"/>
        </sqlMapGenerator>
        <!--生成Dao类存放位置-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.dao" targetProject="src">
            <property name="enableSubPackages" value="true"/>
        </javaClientGenerator>
        <!--生成对应表及类名(跟数据库表保持一致)-->
        <table tableName="ADD_QUOTA_BUSINESS_NODATE" domainObjectName="AddQuotaBusinessNoDate" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
        <table tableName="ADD_QUOTA_FINANCE_NODATE" domainObjectName="AddQuotaFinanceNoDate" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
    </context>
</generatorConfiguration>
```

**配置说明：**

​	location：**对应数据库的驱动名称**
​	jdbcConnection：**数据库连接信息**
​	targetPackage：**生成代码的包名**
​	targetProject：**生成代码的相对路径(必须存在)**
​	table：**每个对应一个表名，实体类名称**

## 4. 生成代码

mybatis-generator目录下cmd执行即可

```
java -jar mybatis-generator-core-1.4.0.jar -configfile generatorConfig.xml -overwrite
```

# 二 Maven方式