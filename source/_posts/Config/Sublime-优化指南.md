---
title: Sublime-优化指南
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


**插件**

```
1 Ctl（Command）+Shift+P 
2 安装：Package Control:Install Package
3 卸载：Package Control:Remove Package
```

**汉化**

```
ChineseLocalizations
```

**格式化 **   

```
pretty，html/css/js
```

**主题**

```
主题：ayu
图标：A File Icon
使用：settings Preferences > Theme（Color Scheme） 选择即可
```

**vue**

```
Vue Syntax Highlight
```

**终端**

```
terminal
```

**Eclipse 快捷键**

Preferences -> Key bindings - User 

```
[  
 { "keys": ["shift+enter"], "command": "run_macro_file", "args": {"file": "Packages/Default/Add Line.sublime-macro"} },  
 { "keys": ["alt+/"], "command": "auto_complete" },//自动提示
 { "keys": ["alt+up"], "command": "swap_line_up" },//整行上移
 { "keys": ["alt+down"], "command": "swap_line_down" },//整行下移
 { "keys": ["alt+left"], "command": "jump_back" },//跳转到上一个编辑处
 { "keys": ["alt+right"], "command": "jump_forward" },
 { "keys": ["ctrl+alt+j"], "command": "join_lines" },  
 { "keys": ["ctrl+d"], "command": "run_macro_file", "args": {"file": "Packages/Default/Delete Line.sublime-macro"} },//整行删除
 { "keys": ["ctrl+h"], "command": "show_panel", "args": {"panel": //搜索全文
 "find_in_files"} },
 { "keys": ["ctrl+l"], "command": "show_overlay", "args": {"overlay": "goto", "text": ":"} },  
 { "keys": ["ctrl+o"], "command": "show_overlay", "args": {"overlay": //跳转到当前的某个方法
 "goto", "text": "@"} },
 { "keys": ["ctrl+up"], "command": "goto_definition" },//跳转到定义，比如在某个函数上按此键，则跳转到它的定义。
 { "keys": ["ctrl+down"], "command": "find_under_prev" },//选中光标所在的变量或者函数，非常有用
 { "keys": ["ctrl+alt+down"], "command": "duplicate_line" },//向下复制整行
 {"keys": ["ctrl+shift+f"], "command": "reindent" , "args":{"single_line": //格式化代码，当然也可以利用html+css+js prettify插件来格式化
 false}},
 { "keys": ["ctrl+shift+r"], "command": "show_overlay", "args": {"overlay": "goto", "show_files": true} },  
 { "keys": ["ctrl+shift+s"], "command": "save_all" },  
 { "keys": ["ctrl+shift+f4"], "command": "close_all" },  
 { "keys": ["ctrl+shift+y"], "command": "lower_case" },  
 { "keys": ["ctrl+shift+x"], "command": "upper_case" } 
]
```

