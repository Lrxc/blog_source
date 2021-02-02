---
title: Rime-导入搜狗词库
date: 2020-07-01 16:01:33
categories: Tool
tags: tool
---

<meta name="referrer" content="no-referrer" />


一 目录认识(可跳过)
1. 打开配制文件 C:\Users\用户\AppData\Roaming\Rime (不是安装目录)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c7ef2e69cab67521.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2.点击开始菜单，找到小狼毫输入法设定，只保留简化字
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7949a5b87b67e5d6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
发现多了一个配置文件，如下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-9fa86de387ec416b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
打开看下 这就是刚才选择的简化字的名称
![image.png](https://upload-images.jianshu.io/upload_images/2803682-dae0e1164080fcad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

二 自定义词库
1 新建 简化字自定义配置文件 luna_pinyin_simp.custom.yaml 输入内容
(自定义配置文件名字格式: 简化字名称.custom.yaml)
```
# luna_pinyin_simp.custom.yaml
patch:
# 指定自定义词库位置
  "translator/dictionary": luna_pinyin.my
```
2 新建luna_pinyin.my.dict.yaml (文件名和上面指定词库位置保持一致)输入内容
(词典名字格式: 名称.dict.yaml)
```
---
name: luna_pinyin.my
version: "1.0"
sort: by_weight
use_preset_vocabulary: true
# 此处为扩充词库（基本）默认链接载入的词库
import_tables:
  - luna_pinyin
...

# 自定义词语
英雄联盟	ying xiong leng meng	100
吃鸡联盟	chi ji lian meng	100
```
最后目录如下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-175337f3cd770f5b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 点击开始菜单，找到小狼毫重新部署，然后输入yxlm显示英雄联盟，搞定。
别人编译好的词库 https://bintray.com/rime-aca/dictionaries/luna_pinyin.dict

三 导入搜狗词库
1 下载搜狗标准词库  https://pinyin.sogou.com/dict/detail/index/11640
2 下载深蓝词库转换  https://github.com/studyzy/imewlconverter
3  转化成功保存txt本地即可
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c16a651c614efad8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4 复制txt文件到Rime 配置目录下，并重命名 luna_pinyin.sougou.dict.yaml 然后打开在最上面添加
```
---
name: luna_pinyin.sougou
version: "1.0"
sort: by_weight
use_preset_vocabulary: true
...
```
5 打开luna_pinyin.my.dict.yaml ，增加搜狗词库，一句话
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e548eb1756f315e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
最后目录如下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-dd107cf6e1b8b1ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
6 重新部署 搞定。


附相关链接：
官方：https://github.com/rime/home/wiki/RimeWithSchemata
大神：https://www.jianshu.com/p/cffc0ea094a7
