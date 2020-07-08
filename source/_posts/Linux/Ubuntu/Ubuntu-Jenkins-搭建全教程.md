---
title: Ubuntu-Jenkins-搭建全教程
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---

<meta name="referrer" content="no-referrer" />


##一 安装Jenkins 
1 需要先安装jdk环境
```
//jenkins 对jdk版本有要求，具体看官网
# sudo apt install openjdk-8-jdk-headless
```
2 配置jenkins
```
//安装命令
# wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update
# sudo apt-get install jenkins
```
3 jenkins 相关命令
```
//
# sudo service jenkins start|stop|restart
# sudo /etc/init.d/jenkins restart
```
官方安装教程：https://jenkins.io/zh/doc/book/installing/#debianubuntu

##二 配置jenkins
1. 获取登录密码
浏览器打开  http://192.168.x.x:8080
```
// ubuntu 执行，获取登录密码
# cat /var/lib/jenkins/secrets/initialAdminPassword
```
2.选择 安装推荐的插件，耐心等待
3. 修改admin密码. 
```
用户列表--->选中admin--->设置--->输入新密码--->保存
```
若界面是英文，把jenkins服务重启下就好了

4. 增加root权限
将root添加到jenkins用户组中，让root用户拥有管理jenkins的权限
```
# sudo gpasswd -a root jenkins
```
让jenkins用root身份运行，配置文件在/etc/default/jenkins
```
JENKINS_USER=root
JENKINS_GROUP=root
```
jenkins的工作目录在/var/lib/jenkins,把jenkins的默认运行用户改成了root
```
sudo chown -R root:root /var/lib/jenkins
```

5. 配置jenkins全局jdk, maven环境
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1a01a84442d3a7ae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
//一般默认jdk路径
/usr/lib/jvm/java-8-openjdk-amd64
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1b3d9c7cc432848f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6. 安装maven项目插件(Maven Integration)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-f239865d3c281f6c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##三 Jenkins 自动部署
1. jenkins新建maven项目
![image.png](https://upload-images.jianshu.io/upload_images/2803682-a343f3bda587d68c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 配置git代码地址
![image.png](https://upload-images.jianshu.io/upload_images/2803682-56f5e89b9c053400.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 打包命令
![image.png](https://upload-images.jianshu.io/upload_images/2803682-5c89debd6e23f319.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 自动部署脚本
![image.png](https://upload-images.jianshu.io/upload_images/2803682-afaf7847ebc7e705.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
# 将应用停止
echo "Stopping SpringBoot Application"
pid=`ps -ef | grep test.jar | grep -v grep | awk '{print $2}'`
if [ -n "$pid" ]
then
   kill -9 $pid
fi
mv -f /var/lib/jenkins/workspace/test/target/jenkins-test-1.0-SNAPSHOT.jar /usr/local/spring/test.jar
chmod 777 /usr/local/spring/test.jar
echo "执行....."
java -jar /usr/local/spring/test.jar
```
后台启动通用版，直接配置即可
```
#服务器名称(pom文件定义)
SERVER_NAME=jenkins-test
# 生成的jar包名称
JAR_NAME=jenkins-test-1.0-SNAPSHOT.jar
# 生成的jar包路径
JAR_PATH=/var/lib/jenkins/workspace/test/target
# 运行jar的工作路径，统一管理，并需要提前创建好
JAR_WORK_PATH=/usr/local/spring

# 将应用停止
echo "Stopping SpringBoot Application"
pid=`ps -ef | grep "$SERVER_NAME" | grep -v grep | awk '{print $2}'`
if [ -n "$pid" ]
then
   kill -9 $pid
fi

mv -f $JAR_PATH/$JAR_NAME $JAR_WORK_PATH
chmod 777 $JAR_WORK_PATH/$JAR_NAME
echo "执行....."
BUILD_ID=dontKillMe nohup java -jar $JAR_WORK_PATH/$JAR_NAME &
```
5 开始构建并查看构建日志
![image.png](https://upload-images.jianshu.io/upload_images/2803682-898f820615e36215.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


四 卸载jenkins
```
//服务
sudo apt-get remove jenkins
//安装包
sudo apt-get remove --auto-remove jenkins
//配置和数据
sudo apt-get purge jenkins
sudo apt-get purge --auto-remove jenkins
```
