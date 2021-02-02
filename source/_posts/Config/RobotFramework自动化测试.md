---
title: RobotFramework自动化测试
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


- 系统：Win10 x64

- Python：3.7.5

  

# 一. 环境搭建

### 1. python环境

官网地址：https://www.python.org/downloads/

介绍：RF框架是基于python 的，所以一定要有python环境。

安装后配置python、pip环境变量

```shell
#python 版本
python --version
#pip 版本
pip --version
#查看已安装插件
pip list
#查看安装插件详细信息
pip show xxx
```

### 2. robotframework 安装

官网地址：https://pypi.org/project/robotframework/

介绍：测试框架

```
pip install robotframework
```


### 3. robotframework-ride 安装

官网地址：https://github.com/robotframework/RIDE/releases

介绍：RIDE就是一个图形界面的用于创建、组织、运行测试的软件。

```
pip install robotframework-ride
```

### 4. wxpython 安装（可选）

官网地址：https://www.wxpython.org/pages/downloads/

介绍：Wxpython 是python 非常有名的一个GUI库，因为RIDE 是基于这个库开发的，所以这个必须安装。

```
pip install wxPython
```

### 5. 启动软件

进入python路径下Scripts下,双击ride.py即可，或者右键选择python打开

启动报错的参考下面

# 二. 测试

### 1 hello world 测试

1. 新建测试文件：New Project --> New Suite --> New Test Case
2. 测试用例

```
test01
    log    hello world
```

### 2 selenium测试

1. 安装依赖

   官网地址：https://github.com/carbonblack/robotframework-selenium2library

   ```
   pip install robotframework-selenium2library
   ```

2. 导入依赖库

<img src="C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200721182629247.png" alt="image-20200721182629247" style="zoom:80%;" />

3. 测试用例

```
#测试代码

```

### 3 接口测试

1. 安装依赖

   官网地址：https://github.com/MarketSquare/robotframework-requests#readme

   ```
   pip install robotframework-requests
   ```

2. 导入依赖库

3. 测试用例

```
*** Settings ***
Library               Collections
Library               RequestsLibrary

*** Test Cases ***
Get Requests
    Create Session    github         http://api.github.com
    Create Session    google         http://www.google.com
    ${resp}=          Get Request    google               /
    Status Should Be  200            ${resp}
    ${resp}=          Get Request    github               /users/bulkan
    Request Should Be Successful     ${resp}
    Dictionary Should Contain Value  ${resp.json()}       Bulkan Evcimen
```

# 3. 技巧

### 1. 桌面快捷启动方式

桌面空白处右击--> 新建--> 快捷方式

```
# 前面是python安装的路径，主要是-c及后面参数
D:\Python37\pythonw.exe -c "from robotide import main; main()"
```

### 2. 三方插件

官网：https://robotframework.org/#libraries

### 3. 启动报错

<img src="C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200721161906148.png" alt="image-20200721161906148" style="zoom:80%;" />

解决：

修改\Lib\site-packages\robotide\application\application.py,增加一行

```
 self.locale = wx.Locale(wx.LANGUAGE_CHINESE_SIMPLIFIED)
```

<img src="C:\Users\Admin\AppData\Roaming\Typora\typora-user-images\image-20200721162028135.png" alt="image-20200721162028135" style="zoom:80%;" />

