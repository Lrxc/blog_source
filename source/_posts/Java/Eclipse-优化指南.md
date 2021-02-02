---
title: Eclipse-优化指南
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


# 常用插件安装

## 1. 安装流程

```
安装方法：
1 在Eclipse内上方菜单栏点击help，找到install new software
2 work with 中输入下面地址，然后回车
```

## 2. 插件url

### 1. 汉化

   ```
url: http://download.eclipse.org/technology/babel/update-site/R0.15.1/oxygen
   ```

   汉化后使用英文版，桌面快捷图标-->属性-->目标
   加上 D:\Eclipse\eclipse\eclipse.exe -nl en

### 2. PropertiesEditor 

    url: http://propedit.sourceforge.jp/eclipse/updates/
    1 Eclipse - help- Install New Software
    2 输入上面url 回车 选择PropertiesEditor 

### 3. Spring Tool Suite(properties 小叶子)

   ```
1. Help -> Eclipse Marketplace
2. Search或选择“Popular”标签，选择Spring Tool Suite (STS) for Eclipse插件
3. 安装，重启
   ```

### 4. SVN

   ```
1. 打开插件地址
Eclipse - help- Install New Software
MyEclipse - help - Install from Site

2. 添加插件地址
http://subclipse.tigris.org/update_1.8.x

3. 两个都打勾，然后就是一直下一步，直到安装成功，安装完成后会提示重启

4. 显示SVN资源库
Window - Show View - Other - SVN - SVN资源库 - 新建资源库
   ```

   