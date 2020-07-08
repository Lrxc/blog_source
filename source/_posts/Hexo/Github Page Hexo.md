---
title: Github Page Hexo
date: 2020-07-02 16:01:33
categories: Hexo
tags: hexo
---

<meta name="referrer" content="no-referrer" />


环境

- nodejs

- git


官网教程：https://hexo.io/zh-cn/docs/github-pages

初始化hexo项目

```
npm install hexo-cli -g
hexo init blog
cd blog
npm install
hexo server
```

浏览器访问localhost:4000

新建github 项目

开启GitHub Pages

打开根目录下的`_config.yml`文件

```
//url是github pages给我们分配的网址
//root是我们搭建该博客的仓库名!
url: https://lrxc.github.io/blog/
root: /blog/
```

```bash
//repo修改为你自己的github项目地址
deploy:
  type: git
  repo: https://github.com/Lrxc/blog.git
  branch: master
```

#### 发布

安装hexo git发布插件

```
npm install hexo-deployer-git --save
```

推送项目到github

```
hexo clean
//hexo generate deploy
hexo g -d
```

查看github厂库，有新代码推送成功了

访问github page https://lrxc.github.io/blog/