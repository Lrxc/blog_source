---
title: MacOS-Homebrew-Jdk-Node
date: 2017-07-01 16:01:33
categories: MacOS
tags: macos
---

<meta name="referrer" content="no-referrer" />

#### 一 安装Homebrew 

- git post 默认值设置

```
git config --global http.postBuffer 1048576000
```

- 官网：[https://brew.sh/index_zh-tw](https://brew.sh/index_zh-tw)

  需要科学上网，dns(114)，终端代理(export http_proxy=http://127.0.0.1:1087)
```
//安装
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
//卸载
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```
- 清华镜像： https://mirror.tuna.tsinghua.edu.cn/help/homebrew/
```
# 设置代理
if [[ "$(uname -s)" == "Linux" ]]; then BREW_TYPE="linuxbrew"; else BREW_TYPE="homebrew"; fi
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/${BREW_TYPE}-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/${BREW_TYPE}-bottles"
```

```
# 从本镜像下载安装脚本并安装 Homebrew / Linuxbrew
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash brew-install/install.sh
rm -rf brew-install
```

- 常用命令
```
brew search 软件名，如brew search wget //搜索软件
brew install 软件名，如brew install wget//安装软件
brew remove 软件名，如brew remove wget//卸载软件
```

#### 二 镜像源
1. [中科大镜像](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)
2. [清华大学开源软件镜像站](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/)

- 替换现有上游
```
# 替换 brew 程序本身的源
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

# 手动设置
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
git -C "$(brew --repo homebrew/cask-versions)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-versions.git\

# 更换上游后需重新设置 git 仓库 HEAD
brew update-reset
```
#### 三 Jdk
 - [参考来源](https://www.cnblogs.com/imzhizi/p/macos-jdk-installation-homebrew.html)
```
//安装不同版本
brew cask install adoptopenjdk8
brew cask install adoptopenjdk9
brew cask install adoptopenjdk10
brew cask install adoptopenjdk11

# 错误情况: Unknown command: cask
brew install --cask adoptopenjdk8

//Jdk卸载
sudo rm -fr /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin 
sudo rm -fr /Library/PreferencePanes/JavaControlPanel.prefPane 
sudo rm -fr ~/Library/Application\ Support/Oracle/Java
删除/Library/Java目录
```
#### 四 Node Js
- 默认安装最高的版本
```
brew install node
brew uninstall nodejs
```
- 安装指定版本
1. 如果之前使用过 brew install node 安装过 node，需要使用 brew unlink node 来解绑
2. 打开命令行，输入 brew search node ，来查询可以安装的 node 版本
3. 可以看到命令行中出现了包括 node@8、node@10 之类的 node 版本信息。选择自己需要安装的版本，进行安装，如使用命令brew install node@10;
4. 输入 node -v进行查看
