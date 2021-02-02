---
title: Ubuntu-Nexus3-Maven私服
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


##一  安装nexus
1 下载nexus镜像
官网：https://help.sonatype.com/repomanager3/download
2. 上传至ubuntu
```
//解压到自己的目录
tar -zxvf  nexus-3.17.0-01-unix.tar.gz .
```
3. 启动nexus
Nexus默认的端口是8081，可以在**etc/nexus-default.properties**配置中修改。
```
//进入bin目录下
./nexux start
```
4.等待一分钟 浏览器访问
http://192.168.234.132:8081/
![image.png](https://upload-images.jianshu.io/upload_images/2803682-95d2d68bbbe2ad7b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以看到账号admin   密码需要手动获取
```
//获取密码
$ cat /usr/local/sonatype-work/nexus3/admin.password
```

##二 上传代码至Nexus
1. 设置厂库可以重复上传
左侧选择Reposiroty—选择厂库maven-releases—找到Hosted—选择Allow redeploy—  Save
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2df3e82c6635e86b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 在maven的 settings.xml 中配置
```
	 <servers>
		<server>
		  <!--nexus 仓库名-->
		  <id>maven-releases</id>
		  <!--nexus 仓库的账号密码-->
		  <username>admin</username>
		  <password>123</password>
		</server>
	 </servers>
```
3 配置项目pom.xml文件
```
    <!--配置maven私服地址，用户打包上传-->
    <distributionManagement>
        <repository>
            <!--id 对应新建仓库的名字-->
            <id>maven-releases</id>
            <url>http://192.168.234.132:8081/repository/test-repository/</url>
        </repository>
    </distributionManagement>
```
4 发布到nexus
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2391492e773f3eda.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
出现BUILD SUCCESS 代表成功。
 5 查看nexus厂库
![image.png](https://upload-images.jianshu.io/upload_images/2803682-8a0a0fa4acb444c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##三 使用私服
1. 直接在项目的pom.xml 添加
```
    <dependencies>
        <!--maven依赖:上传到nexus的代码信息-->
        <dependency>
            <groupId>com.bxlt</groupId>
            <artifactId>nexus_api</artifactId>
            <version>1.0-RELEASE</version>
        </dependency>
    </dependencies>

    <repositories>
        <!--配置nexus私服地址-->
        <repository>
            <id>maven-releases</id>
            <name>maven-releases</name>
            <url>http://192.168.234.132:8081/repository/test-repository/</url>
        </repository>
    </repositories>
```
2. 查看下载地址
![image.png](https://upload-images.jianshu.io/upload_images/2803682-083f4d6547ef5450.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##四. maven的 settings.xml 综合配置
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
   
    <!--该值表示构建系统本地仓库的路径。-->
    <localRepository>E:\Repository\repository</localRepository>

    <!--远程仓库名、用户名、密码，有些仓库访问是需要安全认证的 -->
    <servers>
        <server>
            <!-- 远程厂库的id(Name) -->
            <id>maven-public</id>
            <username>admin</username>
            <password>admin</password>
        </server>
    </servers>
    
    <!--为仓库列表配置的下载镜像列表。  -->
    <mirrors>
        <mirror>
            <!--远程厂库的id(Name)  -->
            <id>maven-public</id>
            <!--此处配置所有的构建均从私有仓库中下载 *代表所有，也可以写central -->
            <mirrorOf>*</mirrorOf>
            <url>http://192.168.234.130:8091/repository/maven-public/</url>
        </mirror>
    </mirrors>
    
    <!--根据环境参数来调整构建配置的列表。-->
    <profiles>
        <profile>
            <id>nexus</id>
            <!--远程仓库列表。  -->
            <repositories>
                <repository>
                	<!-- 远程厂库的id(Name) -->
                    <id>maven-public</id>
                    <url>http://192.168.234.130:8091/repository/maven-public/</url>
	                <!--true或者false表示该仓库是否为下载某种类型构件（发布版，快照版）开启。 -->
	                <releases><enabled>true</enabled></releases>
	                <snapshots><enabled>true</enabled></snapshots>
	            </repository>
            </repositories>
            <!-- 插件仓库列表 -->
            <pluginRepositories>
                <pluginRepository>
                    <id>maven-public</id>
                    <url>http://192.168.234.130:8091/repository/maven-public/</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
    
    <!--激活配置-->
    <activeProfiles>
        <!--profile下的id-->
        <activeProfile>nexus</activeProfile>
    </activeProfiles>
</settings>
```
##参考文章：
https://blog.csdn.net/fly910905/article/details/78668677
https://cloud.tencent.com/developer/article/1014577
