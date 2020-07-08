---
title: init
date: 2019-07-01 16:01:33
categories: Vue
tags: vue
---

<meta name="referrer" content="no-referrer" />


# shopdemo

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


环境搭建：


### 安装 `npm`

`npm` 全称为 `Node Package Manager`，是一个基于`Node.js`的包管理器，也是整个`Node.js`社区最流行、支持的第三方模块最多的包管理器。

```
npm -v
//查看安装了哪些包
npm list --depth=0
```

### 由于网络原因 安装 `cnpm`

```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

### 安装 `vue-cli`

2.x: 

```
cnpm install -g vue-cli
```

3.x:  

```
cnpm install -g @vue/cli
```

### 安装 `webpack`

`webpack` 是  `JavaScript` 打包器(module bundler)

```
cnpm install -g webpack
```

### 创建一个项目

2.x:  

```
vue init webpack my-project
```

3.x:  

```
vue create my-project
# OR
vue ui
```
