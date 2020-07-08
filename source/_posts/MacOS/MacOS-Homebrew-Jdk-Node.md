---
title: MacOS-Homebrew-Jdk-Node
date: 2017-07-01 16:01:33
categories: MacOS
tags: macos
---

<meta name="referrer" content="no-referrer" />


#### 一 安装Homebrew 
- 官网：[https://brew.sh/index_zh-tw](https://brew.sh/index_zh-tw)
```
//安装
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
//卸载
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
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
3. [知乎](https://www.zhihu.com/question/31360766)

- 替换现有上游
```
替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
```
- 复原
```
重置brew.git:
cd "$(brew --repo)"
git remote set-url origin https://github.com/Homebrew/brew.git

重置homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

#### 三 Java-Jdk
 - [参考来源](https://www.cnblogs.com/imzhizi/p/macos-jdk-installation-homebrew.html)
```
# AdoptOpenJDK 
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk8
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk9
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk10
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk11
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk12
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk

# Azul Zulu 提供了 JDK 7
# Azul Zulu 也提供其他版本的 JDK 像 zulu8、zulu11 等
brew cask install homebrew/cask-versions/zulu7
brew cask install homebrew/cask-versions/zulu8
brew cask install homebrew/cask-versions/zulu11
brew cask install homebrew/cask-versions/zulu

# Apple 提供的 JDK6
brew cask install homebrew/cask-versions/java6
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
