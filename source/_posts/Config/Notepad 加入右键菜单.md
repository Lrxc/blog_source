---
title: Notepad 加入右键菜单
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


下内容保存为 .reg 文件，双击运行即可：

    Windows Registry Editor Version 5.00
    
    [HKEY_CLASSES_ROOT\*\shell\NotePad++]
    @="Edit with &Notepad++"
    "Icon"="C:\\Program Files\\Notepad++\\notepad++.exe"
    
    [HKEY_CLASSES_ROOT\*\shell\NotePad++\Command]
    @="C:\\Program Files\\Notepad++\\notepad++.exe \"%1\""

Sublime：

    Windows Registry Editor Version 5.00

    [HKEY_CLASSES_ROOT\*\shell\sublime_text]
    @="Edit with sublime_text"
    "Icon"="D:\\Java\\Sublime\\sublime_text.exe"
    
    [HKEY_CLASSES_ROOT\*\shell\sublime_text\Command]
    @="D:\\Java\\Sublime\\sublime_text.exe \"%1\""

如果要删除右键菜单，也是一样的道理：
    
    Windows Registry Editor Version 5.00

    [-HKEY_CLASSES_ROOT\*\shell\NotePad++]