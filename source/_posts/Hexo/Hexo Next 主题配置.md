---
title: Hexo Next 主题配置
date: 2020-07-02 16:01:33
categories: Hexo
tags: hexo
---

<meta name="referrer" content="no-referrer" />


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

#### 六 主题设置

默认针对主题配置文件

##### 1. 页面样式

```bash
scheme: Muse    #上下布局
scheme: Pisces  #左右布局
```

##### 2. 设置语言

```
//站点配置文件
language: zh-CN
```

##### 3. 头像

```
avatar:
  url: /images/ico.jpg #图片路径
  rounded: true  # 圆角
  rotated: true  # 旋转
```

##### 4. 友情链接

```
links:
  Github: https://github.com/Lrxc
  Weibo: http://example.com/
  WeChat: http://example.com/
  
social_icons:
  enable: true      # 显示社交图标
  icons_only: false # 只显示图标，不显示文字
```

##### 5. 底部

```
footer:
  since: 2018        # 建站开始时间
  icon:
    name: user       # 设置 建站初始时间和至今时间中间的图标，默认是一个'小人像'，更改user为heart可以变成一个心
    animated: true
    color: "#808080" # 更改图标的颜色，红色为'#ff0000'
  powered:
    enable: true     # 开启hexo驱动
    version: true    # 开启hexo版本号
  theme:
    enable: true     # 开启主题驱动
    version: true    # 开启主题版本号
  custom_text: Hosted by <a target="_blank" rel="external nofollow" href="https://pages.coding.me"><b>Coding Pages</b></a> # 这里的底部标识是为了添加coding page服务时的版权声明 打开注释就可以看到底部有一个 hosted by coding pages
```

##### 6. 文章自动折叠

```
auto_excerpt:
  enable: true #自动折叠文章
  length: 150  #显示行数
```

##### 7. 首页显示几篇文章

站点配置文件

```
index_generator:
  per_page: 6  #一页显示几条文章
```

##### 8. 页面统计人数

```
busuanzi_count:
  enable: false              # 设true 开启
  total_visitors: true       # 总阅读人数（uv数）
  total_visitors_icon: user  # 阅读总人数的图标
  total_views: true          # 总阅读次数（pv数）
  total_views_icon: eye      # 阅读总次数的图标
  post_views: true           # 开启内容阅读次数
  post_views_icon: eye       # 内容页阅读数的图标

```

##### 9. 本地搜索功能

安装搜索插件： `hexo-generator-searchdb`，根目录下执行以下命令
```
$ npm install hexo-generator-searchdb --save
```

站点配置文件_config.yml

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

主题配置文件_config.yml

```
local_search:
  enable: true
```

##### 10. 字数统计，阅读时长

安装插件

```
npm install hexo-symbols-count-time --save
```

主题配置文件`_config.yml` 修改如下

```
symbols_count_time:
  separated_meta: true  # false会显示一行
  item_text_post: true  # 显示属性名称,设为false后只显示图标和统计数字,不显示属性的文字
  item_text_total: true # 底部footer是否显示字数统计属性文字
  awl: 4                # 计算字数的一个设置,没设置过
  wpm: 275              # 一分钟阅读的字数
```

站点配置文件`_config.yml` 新增如下

```
symbols_count_time:
 #文章内是否显示
  symbols: true
  time: true
 # 网页底部是否显示
  total_symbols: true
  total_time: true
```

##### 11. 内容页里的代码块新增复制按钮

```
codeblock:
  copy_button:
    enable: false      # 增加复制按钮的开关
    show_result: false # 点击复制完后是否显示 复制成功 结果提示
```

##### 12. 配置微信，支付宝打赏

```
# Reward
reward_comment:                   # 打赏描述
wechatpay: /images/wechatpay.png  # 微信支付的二维码图片地址
alipay: /images/alipay.png        # 支付宝的地址
#bitcoin: /images/bitcoin.png     # 比特币地址
```

##### 13. 声明文章原创

```
creative_commons:
  license: by-nc-sa
  sidebar: false
  post: true       # 默认显示版权信息
  language:
```

##### 14. 相关文章推荐

安装推荐文章的插件

```
npm install hexo-related-popular-posts --save
```

主题配置

```
related_posts:
  enable: true
  title: 相关文章推荐      # 属性的命名
  display_in_home: false # false代表首页不显示
  params:
    maxCount: 5          # 最多5条
    #PPMixingRate: 0.0   # 相关度
    #isDate: true        # 是否显示日期
    #isImage: false      # 是否显示配图
    isExcerpt: false     # 是否显示摘要
```

##### 15. 背景动画设置

#### Canvas-nest 风格

进入 `theme/next` 目录，执行命令：

```
git clone https://github.com/theme-next/theme-next-canvas-nest source/lib/canvas-nest
```

实际上就是将一个显示动效的 js 文件 clone 到对应目录。

这时将配置文件`_config.yml` 中的 `canvas_nest: false` 改为 `canvas_nest: true` 才能真正生效。