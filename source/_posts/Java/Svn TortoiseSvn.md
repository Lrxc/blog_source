---
title: Svn TortoiseSvn
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


# 一 代码回滚

```
1. 右击要回滚的文件或文件夹, TortoiseSVN -> Show log	
2. 选择你要恢复到(revert)的版本。要全部回滚到某个版本就是用了Revert to this revision. 
3. 如果你想撤销(undo)一个段版本范围，选择第一个，按住Shift键选中最后一个。
	如果需要选择一些分离的版本，请使用Ctrl键。
	选中后右键再选择 Revert Changes from this revision.
	这两种的区别是第一个很彻底，第二种只修改选中的部分
4. 现在的文件已经revert(恢复)成了你想要的历史状态，重新commit即可。
```
# 二 常见问题

#### 1. TortoiseSVN全局忽略文件或文件夹

1. 右键任意位置，找到【TortoiseSVN】→【Settings】，在弹出窗口中，在【General】→【Global ignore pattrn】，这里有一个输入框，目前添加后不生效，直接点击下面的【Edit】按钮

2. 在配置文件里找到【global-ignores =】这一行，在后面添加想要忽略的文件或文件夹，规则时间用空格分隔，支持正则规则

   ```
   global-ignores = *.o *.lo *.la *.al .libs *.so *.so.[0-9]* *.a *.pyc *.pyo __pycache__
    *.rej *~ #*# .#* .*.swp .DS_Store [Tt]humbs.db
    .settings */.settings/* .idea */.idea/* target */target/* 
    *.classpath *.project *.iml *.log *.jar 
   ```

3. 保存即可生效

#### 2. SVN更换新仓库地址, 以及UUID不同的解决方式

```
--修改本地uuid 
sqlite3 .svn/wc.db 
sqlite> select * from REPOSITORY; #一般是只有一条记录, 修改后会有两条 
sqlite> update REPOSITORY set uuid="bdbd6e13-965c-4da7-a4da-d4840425081e" where id=1; 
sqlite> .exit 

svn update即可 
```