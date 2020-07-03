---
title: Hexo Next 主题配置
date: 2020-07-02 16:01:33
categories: Hexo
tags: hexo
---


官网教程：https://theme-next.iissnan.com/getting-started.html

## 说明

```
在 Hexo 中有两份主要的配置文件，其名称都是 _config.yml。 其中，一份位于站点根目录下，主要包含 Hexo 本身的配置；另一份位于主题目录下，这份配置由主题作者提供，主要用于配置主题相关的选项。
为了描述方便，在以下说明中，将前者称为 站点配置文件， 后者称为 主题配置文件
```

#### 一 下载主题

```
$ cd your-hexo-site
$ git clone https://github.com/theme-next/hexo-theme-next themes/next
```

#### 二 启用主题

与所有 Hexo 主题启用的模式一样。 当 克隆/下载 完成后，打开 **站点配置文件**， 找到 `theme` 字段，并将其值更改为 `next`

```
theme: next
```

#### 三 编辑菜单

启用需要的菜单

```
//----|| 前面是路径,后面是图标ico
menu:
  home: / || home
  categories: / categories/|| th
  tags: /tags/ || tags
  archives: /archives/ || archive
  about: /about/ || user
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat
```

手动创建对应页面

```
hexo new page 'categories'
hexo new page 'tags'
hexo new page 'about'
```

\source路径下对应名称的index.md增加type属性

```
---
title: categories
date: 2018-07-30 16:28:33
type: categories
---
```

```
---
title: tags
date: 2018-07-30 16:28:54
type: tags
---
```

```
---
title: about
date: 2018-07-30 16:29:13
type: about
---
```

新建一篇文章

```
hexo new "test"
```

编辑 \source\_posts\test.md 文件

```
---
title: one
date: 2020-07-01 16:01:33
tags: [标签1,标签2]
categories: 
- Java分类
- Java分类的二级菜单
---
```

刷新浏览器，就可以看到效果了

#### 五 全局搜索功能

安装搜索插件： `hexo-generator-searchdb`，根目录下执行以下命令
```
$ npm install hexo-generator-searchdb --save
```

项目根路径_config.yml

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

next的_config.yml

```
local_search:
  enable: true
```

#### 六 主题设置

1. 页面样式

```bash
scheme: Muse    #上下布局
scheme: Pisces  #左右布局
```

2. 设置语言

```
//站点配置文件
language: zh-CN
```

3. 头像

```
avatar:
  url: /images/ico.jpg #图片路径
  rounded: true  # 圆角
  rotated: true  # 旋转
```

4. 友情链接

```
links:
  Github: https://github.com/Lrxc
  Weibo: http://example.com/
  WeChat: http://example.com/
```

5. 底部

```
footer:
  # Powered by Hexo & NexT
  powered: false
```

6. 文章自动折叠

```
auto_excerpt:
  enable: true #自动折叠文章
  length: 150  #显示行数
```

7. 一页显示几篇文章

```
//站点配置文件
index_generator:
  per_page: 6  #一页显示几条文章
```

