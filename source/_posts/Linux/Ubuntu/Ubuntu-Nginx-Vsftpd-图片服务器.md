---
title: Ubuntu-Nginx-Vsftpd-图片服务器
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：ubuntu 18.04 LTS
- Nginx: 1.16.0
- Vsftpd: 3.0.3

##一.安装Vsftpd
1. 安装
```
sudo apt-get install vsftpd
```
2. 配置vsftpd
```
vim /etc/vsftpd.conf
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-71ac5a0ec73b1618.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 增加用户
```
//增加用户
$ useradd ftp
//设置密码
$ passwd ftp
````
切换用户ftp登录  提示This account is currently not available问题：
修改登录权限，把/sbin /nologin 改成/bin/bash
```
$ vim /etc/passwd
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-12c3da124b1f8140.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 创建文件夹，用于以后存放图片
```
$ cd /home
$ mkdir ftp
// 改变用户的拥有者及用户组: chown [-R] 账号名称:用户组名称 文件或目录
$ chown ftp:ftp ftp
````
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2d4d4c057a97666a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
5.测试, 外网访问
```
ftp localhost
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ace5a69acaa1ffb1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 二. 配置Nginx
1 安装：https://www.jianshu.com/p/20157e8a0b06
2 编辑nginx.conf
**sudo vi /etc/nginx/nginx.conf**
```
http {
	...
    server {
        listen       80;
        server_name  localhost;

	location / {
            root   /home/ftp;
            index  index.html index.htm;
        }
    }
	...
}
```
2. 上传一张图片 1.jpg 到 /home/ftp 下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ce43017f272738b1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 浏览器访问
![image.png](https://upload-images.jianshu.io/upload_images/2803682-03607234d147bdcd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Java代码上传
```
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

/**
 * ftp上传下载工具类
 */
public class FtpUtil {

	/** 
	 * Description: 向FTP服务器上传文件 
	 * @param host FTP服务器hostname 
	 * @param port FTP服务器端口 
	 * @param username FTP登录账号 
	 * @param password FTP登录密码 
	 * @param basePath FTP服务器基础目录
	 * @param filePath FTP服务器文件存放路径。例如分日期存放：/2015/01/01。文件的路径为basePath+filePath
	 * @param filename 上传到FTP服务器上的文件名 
	 * @param input 输入流 
	 * @return 成功返回true，否则返回false 
	 */  
public static boolean uploadFile(String host, int port, String username, String password, String basePath,
			String filePath, String filename, InputStream input) {
		boolean result = false;
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			ftp.connect(host, port);// 连接FTP服务器
			// 如果采用默认端口，可以使用ftp.connect(host)的方式直接连接FTP服务器
			ftp.login(username, password);// 登录
			reply = ftp.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				System.out.println("ftp登录失败");
				ftp.disconnect();
				return result;
			}
			//切换到上传目录
			if (!ftp.changeWorkingDirectory(basePath+filePath)) {
				//如果目录不存在创建目录
				String[] dirs = filePath.split("/");
				String tempPath = basePath;
				for (String dir : dirs) {
					if (null == dir || "".equals(dir)) continue;
					tempPath += "/" + dir;
					if (!ftp.changeWorkingDirectory(tempPath)) {
						if (!ftp.makeDirectory(tempPath)) {
							return result;
						} else {
							ftp.changeWorkingDirectory(tempPath);
						}
					}
				}
			}
			//设置上传文件的类型为二进制类型
			ftp.setFileType(FTP.BINARY_FILE_TYPE);
			//上传文件
			if (!ftp.storeFile(filename, input)) {
				return result;
			}
			input.close();
			ftp.logout();
			result = true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return result;
	}
	
	/** 
	 * Description: 从FTP服务器下载文件 
	 * @param host FTP服务器hostname 
	 * @param port FTP服务器端口 
	 * @param username FTP登录账号 
	 * @param password FTP登录密码 
	 * @param remotePath FTP服务器上的相对路径 
	 * @param fileName 要下载的文件名 
	 * @param localPath 下载后保存到本地的路径 
	 * @return 
	 */  
	public static boolean downloadFile(String host, int port, String username, String password, String remotePath,
			String fileName, String localPath) {
		boolean result = false;
		FTPClient ftp = new FTPClient();
		try {
			int reply;
			ftp.connect(host, port);
			// 如果采用默认端口，可以使用ftp.connect(host)的方式直接连接FTP服务器
			ftp.login(username, password);// 登录
			reply = ftp.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				ftp.disconnect();
				return result;
			}
			ftp.changeWorkingDirectory(remotePath);// 转移到FTP服务器目录
			FTPFile[] fs = ftp.listFiles();
			for (FTPFile ff : fs) {
				if (ff.getName().equals(fileName)) {
					File localFile = new File(localPath + "/" + ff.getName());

					OutputStream is = new FileOutputStream(localFile);
					ftp.retrieveFile(ff.getName(), is);
					is.close();
				}
			}

			ftp.logout();
			result = true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch (IOException ioe) {
				}
			}
		}
		return result;
	}
	
	public static void main(String[] args) {
		try {  
	        FileInputStream in=new FileInputStream(new File("E:/a.png"));  
	        boolean flag = uploadFile("192.168.17.129", 21, "ftpuser", "ftpuser", "/home/ftp","/", "abc1.png", in);  
	        System.out.println(flag);  
	    } catch (FileNotFoundException e) {  
	        e.printStackTrace();  
	    }  
	}
}

```
