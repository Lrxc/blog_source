---
title: Git TortoiseGit
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


# 一 基础命令

http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

1. 上传项目

   ```
   git add *					//加入所有项目
   git status					//检查状态 如果都是绿的 证明成功
   git commit -m "这是提交说明"	//提交到要地仓库，并写一些注释
   git push					//推送到服务器
   ```
   
2. 清理

   ```
   git clean -xdf
   ```

# 二 代码回滚

1. TortoiseGit 远程回滚

   ```
   1. 第一步git show log,然后在你先要回退的提交记录上右键 
   2. 选择resert **** to this,然后选择最后一个Hard:Reset.......，点ok
   3. git命令进到代码的目录下，强制同步本地代码到远端，执行 git push -f
   ```

2. 回滚:
   
   ```
   git log -3 //查看最近3次的提交记录(查看coommit_id)
   git reset --hard commit_id //重置到某次提交
   ```

# 三 常见问题

1. SourceTree 一直提示输入密码

   ```
   //修改SourceTree 中厂库地址
   http://xxx/xx.Git 
   修改为：http://username:password@xxxxx/xxxx.git （即新增username:password@）
   ```

2. TortoiseGit一直提示输入密码

   ```
   //编辑 global.gitconfig
   [credential]
       helper = store
   ```

3. fatal: The remote end hung up unexpectedly

    ```
    Mac:
     git config --global http.postBuffer 524288000
    Windows:
     [http]
     postBuffer = 524288000
    ```


