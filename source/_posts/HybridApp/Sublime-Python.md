---
title: Sublime-Python
date: 2017-07-01 16:01:33
categories: HybridApp
tags: hybridapp
---

<meta name="referrer" content="no-referrer" />


Sublime安装插件

一 侧菜单：
control + ~，打开
```
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```
侧边栏样式
```
1 Ctrl+Shift+P --> install package-->"theme-Afterglow"
2 安装完成后，修改preferences-->setting
3 "theme": "Afterglow.sublime-theme",   //侧边栏的主题样式
```
二 改变快捷键
```
1 Preferneces->Key BInding
```
三 运行Python
一 
右下角选择语言

二 编辑
```
Tools-->Build System-->Python
Ctrl +B //跑起来
```

四 html格式化
```
html-css-js prettify
```


