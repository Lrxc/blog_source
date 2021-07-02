## 访问地址

github page: https://lrxc.github.io/blog/



## 下载运行

安装依赖

```
cd blog_source
npm install hexo --save
npm install hexo-cli -g
//远程git
npm install hexo-deployer-git --save
```

运行项目

```
//清理缓存
hexo clean
//本地运行
hexo s
//打包并发布,先删除.deploy_git文件夹
hexo g -d
```

## 配置

```yml
_config.yml 
#github page地址:
url: xxx
#git地址
deploy:
  repo: xxx
```

## 三方链接

```
Hexo官网：https://hexo.io/zh-cn/docs/
Next主题：https://theme-next.iissnan.com/getting-started.html
```



