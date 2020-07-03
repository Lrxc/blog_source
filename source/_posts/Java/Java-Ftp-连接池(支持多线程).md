---
title: Java-Ftp-连接池(支持多线程)
date: 2019-07-01 16:01:33
categories: Java
tags: java
---


##环境及版本：
- 框架：SpringMVC 5.1.7.RELEASE
             commons-net 3.6
             commons-pool 2 2.7.0

####1. pom.xml中添加依赖
```
 <!-- ftp -->
 <dependency>
     <groupId>commons-net</groupId>
     <artifactId>commons-net</artifactId>
     <version>3.6</version>
 </dependency>
 <!-- 使用commons-pool2 实现ftp连接池 -->
 <dependency>
     <groupId>org.apache.commons</groupId>
     <artifactId>commons-pool2</artifactId>
     <version>2.7.0</version>
 </dependency>
```
####2. 配置文件
```
#ftp服务器配置
ftp.host=192.168.241.128
ftp.port=21
ftp.username=ftp_user
ftp.password=123
#超时时间(0表示一直连接)
ftp.clientTimeout=0
ftp.connectTimeout=0
#编码格式
ftp.encoding=UTF-8
#缓冲器大小
ftp.bufferSize=1024
#每次数据连接之前，ftp client告诉ftp server开通一个端口来传输数据
ftp.passiveMode=true
#连接池数量
ftp.defaultpoolsize=10


#FTP连接池配置
#最大数
ftpPool.maxTotal=50
#最小空闲
ftpPool.minIdle=0
#最大空闲
ftpPool.maxIdle=50
#最大等待时间
ftpPool.maxWait=-1
#池对象耗尽之后是否阻塞,maxWait<0时一直等待
ftpPool.blockWhenExhausted=true
#取对象是验证
ftpPool.testOnBorrow=true
#回收验证
ftpPool.testOnReturn=true
#创建时验证
ftpPool.testOnCreate=true
#空闲验证
ftpPool.testWhileIdle=false
#后进先出
ftpPool.lifo=false
```
####3. FtpClient工厂类
```
package com.longway.busi.component;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.pool2.BasePooledObjectFactory;
import org.apache.commons.pool2.PooledObject;
import org.apache.commons.pool2.impl.DefaultPooledObject;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @description:
 * @title: FTP 工厂
 * @author: lrxc
 * @date: 2019/11/18 19:12
 */
@Component
public class FtpClientFactory extends BasePooledObjectFactory<FTPClient> {

    @Value("${ftp.host}")
    private String host;
    @Value("${ftp.port}")
    private int port;
    @Value("${ftp.username}")
    private String username;
    @Value("${ftp.password}")
    private String password;
    @Value("${ftp.clientTimeout}")
    private int clientTimeout;
    @Value("${ftp.connectTimeout}")
    private int connectTimeout;
    @Value("${ftp.encoding}")
    private String encoding;
    @Value("${ftp.bufferSize}")
    private int bufferSize;
    @Value("${ftp.passiveMode}")
    private boolean passiveMode;

    private final static Logger log = Logger.getLogger(FtpClientFactory.class.getName());

    /**
     * 创建FtpClient对象
     */
    @Override
    public FTPClient create() {
        FTPClient ftpClient = new FTPClient();
        ftpClient.setConnectTimeout(connectTimeout);
        try {
            ftpClient.connect(host, port);
            int replyCode = ftpClient.getReplyCode();
            if (!FTPReply.isPositiveCompletion(replyCode)) {
                ftpClient.disconnect();
                log.warn("FTPServer 连接失败,replyCode: " + replyCode);
                return null;
            }

            if (!ftpClient.login(username, password)) {
                log.warn("ftpClient 登录失败： " + username + password);
                return null;
            }
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);//文件类型
            ftpClient.setControlEncoding(encoding);
            ftpClient.setBufferSize(bufferSize);
            if (passiveMode) {
                //这个方法的意思就是每次数据连接之前，ftp client告诉ftp server开通一个端口来传输数据
                ftpClient.enterLocalPassiveMode();
            }
            ftpClient.setSoTimeout(clientTimeout);
        } catch (IOException e) {
            log.error("FtpClient 创建错误： " + e.toString());
        }
        return ftpClient;
    }

    /**
     * 用PooledObject封装对象放入池中
     */
    @Override
    public PooledObject<FTPClient> wrap(FTPClient ftpClient) {
        return new DefaultPooledObject<>(ftpClient);
    }

    /**
     * 销毁FtpClient对象
     */
    @Override
    public void destroyObject(PooledObject<FTPClient> ftpPooled) {
        if (ftpPooled == null) {
            return;
        }

        FTPClient ftpClient = ftpPooled.getObject();
        try {
            if (ftpClient.isConnected()) {
                ftpClient.logout();
            }
        } catch (Exception io) {
            log.error("销毁FtpClient错误..." + io.toString());
        } finally {
            try {
                ftpClient.disconnect();
            } catch (IOException io) {
                log.error("销毁FtpClient错误..." + io.toString());
            }
        }
    }

    /**
     * 验证FtpClient对象
     */
    @Override
    public boolean validateObject(PooledObject<FTPClient> ftpPooled) {
        try {
            FTPClient ftpClient = ftpPooled.getObject();
            return ftpClient.sendNoOp();
        } catch (IOException e) {
            log.error("验证FtpClient对象错误: " + e.toString());
        }
        return false;
    }
}
```
####4. 创建连接池
```
package com.longway.busi.component;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * @description:
 * @title: 官方FTP连接池
 * @author: lrxc
 * @date: 2019/12/03 19:09
 */
@Component
public class FtpClientPool {

    @Value("${ftpPool.maxTotal}")
    private int maxTotal;
    @Value("${ftpPool.minIdle}")
    private int minIdle;
    @Value("${ftpPool.maxIdle}")
    private int maxIdle;
    @Value("${ftpPool.maxWait}")
    private long maxWait;
    @Value("${ftpPool.blockWhenExhausted}")
    private boolean blockWhenExhausted;
    @Value("${ftpPool.testOnBorrow}")
    private boolean testOnBorrow;
    @Value("${ftpPool.testOnReturn}")
    private boolean testOnReturn;
    @Value("${ftpPool.testOnCreate}")
    private boolean testOnCreate;
    @Value("${ftpPool.testWhileIdle}")
    private boolean testWhileIdle;
    @Value("${ftpPool.lifo}")
    private boolean lifo;

    //连接池
    private GenericObjectPool<FTPClient> ftpClientPool;

    @Autowired
    private FtpClientFactory ftpClientFactory;

    /**
     * 初始化连接池
     */
    @PostConstruct //加上该注解表明该方法会在bean初始化后调用
    public void init() {
        // 初始化对象池配置
        GenericObjectPoolConfig<FTPClient> poolConfig = new GenericObjectPoolConfig<FTPClient>();
        poolConfig.setBlockWhenExhausted(blockWhenExhausted);
        poolConfig.setMaxWaitMillis(maxWait);
        poolConfig.setMinIdle(minIdle);
        poolConfig.setMaxIdle(maxIdle);
        poolConfig.setMaxTotal(maxTotal);
        poolConfig.setTestOnBorrow(testOnBorrow);
        poolConfig.setTestOnReturn(testOnReturn);
        poolConfig.setTestOnCreate(testOnCreate);
        poolConfig.setTestWhileIdle(testWhileIdle);
        poolConfig.setLifo(lifo);

        // 初始化对象池
        ftpClientPool = new GenericObjectPool<FTPClient>(ftpClientFactory, poolConfig);
    }

    public FTPClient borrowObject() throws Exception {
        return ftpClientPool.borrowObject();
    }

    public void returnObject(FTPClient ftpClient) {
        ftpClientPool.returnObject(ftpClient);
    }
}
```
####5. 封装ftp上传下载工具类
```
package com.longway.busi.component;

import org.apache.commons.io.IOUtils;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.commons.net.io.CopyStreamAdapter;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.io.*;

/**
 * @description:
 * @title: 实现文件上传下载
 * @author: lrxc
 * @date: 2019/11/19 14:09
 */
@Component
public class FtpClientTemplate {

    private final static Logger log = Logger.getLogger(FtpClientTemplate.class.getName());

    @Autowired
    private FtpClientPool ftpClientPool;

    /***
     * 上传Ftp文件
     *
     * @param localFile 本地文件路径
     * @param remotePath 上传服务器路径 - (/abc/1.txt)
     * @return true or false
     */
    public boolean uploadFile(File localFile, String remotePath) {
        FTPClient ftpClient = null;
        BufferedInputStream inStream = null;
        try {
            //从池中获取对象
            ftpClient = ftpClientPool.borrowObject();
            // 验证FTP服务器是否登录成功
            int replyCode = ftpClient.getReplyCode();
            if (!FTPReply.isPositiveCompletion(replyCode)) {
                log.warn("FTP服务器校验失败, 上传replyCode:{}" + replyCode+"   "+localFile);
                return false;
            }

            //切换到上传目录
            if (!ftpClient.changeWorkingDirectory(remotePath)) {
                //如果目录不存在创建目录
                String[] dirs = remotePath.split("/");
                String tempPath = "";
                for (String dir : dirs) {
                    if (null == dir || "".equals(dir)) continue;
                    tempPath += "/" + dir;
                    if (!ftpClient.changeWorkingDirectory(tempPath)) {
                        if (!ftpClient.makeDirectory(tempPath)) {
                            return false;
                        } else {
                            ftpClient.changeWorkingDirectory(tempPath);
                        }
                    }
                }
            }

            inStream = new BufferedInputStream(new FileInputStream(localFile));
            //设置上传文件的类型为二进制类型
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            //尝试上传三次
            for (int j = 0; j < 3; j++) {
                //避免进度回调过于频繁
                final int[] temp = {0};
                //上传进度监控
                ftpClient.setCopyStreamListener(new CopyStreamAdapter() {
                    @Override
                    public void bytesTransferred(long totalBytesTransferred, int bytesTransferred, long streamSize) {
                        int percent = (int) (totalBytesTransferred * 100 / localFile.length());
                        if (temp[0] < percent) {
                            temp[0] = percent;
                            log.info("↑↑   上传进度    " + percent + "     " + localFile.getAbsolutePath());
                        }
                    }
                });

                boolean success = ftpClient.storeFile(localFile.getName(), inStream);
                if (success) {
                    log.info("文件上传成功! " + localFile.getName());
                    return true;
                }
                log.info("文件上传失败" + localFile.getName() + "  重试 " + j);
            }
            log.info("文件上传多次仍失败" + localFile.getName());
        } catch (Exception e) {
            log.error("文件上传错误! " + localFile.getName(), e);
        } finally {
            IOUtils.closeQuietly(inStream);
            //将对象放回池中
            ftpClientPool.returnObject(ftpClient);
        }
        return false;
    }

    /**
     * 下载文件
     *
     * @param remotePath FTP服务器文件目录
     * @param fileName   需要下载的文件名称
     * @param localPath  下载后的文件路径
     * @return true or false
     */
    public boolean downloadFile(String remotePath, String fileName, String localPath) {
        FTPClient ftpClient = null;
        OutputStream outputStream = null;
        try {
            ftpClient = ftpClientPool.borrowObject();
            // 验证FTP服务器是否登录成功
            int replyCode = ftpClient.getReplyCode();
            if (!FTPReply.isPositiveCompletion(replyCode)) {
                log.warn("FTP服务器校验失败, 下载replyCode:{}" + replyCode + "  " + localPath + "/" + fileName);
                return false;
            }

            // 切换FTP目录
            ftpClient.changeWorkingDirectory(remotePath);
            FTPFile[] ftpFiles = ftpClient.listFiles();
            for (FTPFile file : ftpFiles) {
                if (fileName.equalsIgnoreCase(file.getName())) {
                    //保存至本地路径
                    File localFile = new File(localPath + "/" + file.getName());
                    //创建父级目录
                    if (!localFile.getParentFile().exists()) {
                        localFile.getParentFile().mkdirs();
                    }

                    //尝试下载三次
                    for (int i = 0; i < 3; i++) {
                        //避免进度回调过于频繁
                        final int[] temp = {0};
                        //下载进度监控
                        ftpClient.setCopyStreamListener(new CopyStreamAdapter() {
                            @Override
                            public void bytesTransferred(long totalBytesTransferred, int bytesTransferred, long streamSize) {
                                int percent = (int) (totalBytesTransferred * 100 / file.getSize());
                                if (temp[0] < percent) {
                                    temp[0] = percent;
                                    log.info("  ↓↓ 下载进度    " + percent + "     " + localFile.getAbsolutePath());
                                }
                            }
                        });

                        outputStream = new FileOutputStream(localFile);
                        boolean success = ftpClient.retrieveFile(file.getName(), outputStream);
                        outputStream.flush();
                        if (success) {
                            log.info("文件下载成功! " + localFile.getName());
                            return true;
                        }
                        log.info("文件下载失败" + localFile.getName() + "  重试 " + i);
                    }
                    log.info("文件下载多次仍失败" + localFile.getName());
                }
            }
        } catch (Exception e) {
            log.error("文件下载错误! " + remotePath + "/" + fileName, e);
        } finally {
            IOUtils.closeQuietly(outputStream);
            ftpClientPool.returnObject(ftpClient);
        }
        return false;
    }
}
```
####6. 测试类
```
package com.bxlt.test;

import com.bxlt.component.FtpClientTemplate;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;

@RunWith(SpringJUnit4ClassRunner.class)//用于在JUnit环境下提供Spring Test框架的功能。
@ContextConfiguration(locations = {"classpath*:*.xml"})//用来加载配置文件
public class FtpTest {

    @Autowired
    private FtpClientTemplate ftpClientTemplate;

    @Test
    public void download() {
        ftpClientTemplate.downloadFile("/aaa", "gaofeng.tgz", "E:\\aaa");
    }

    @Test
    public void upload() {
        File file = new File("E:\\aaa\\gaofeng.tgz");
        ftpClientTemplate.uploadFile(file, "/abc");
    }
}
```

