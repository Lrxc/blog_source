---
title: Ubuntu-MongoDB 配置
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：ubuntu 18.04 LTS

- MongoDB: 

  

## 一 安装

```
sudo apt update && sudo apt upgrade -y
sudo apt install mongodb
sudo systemctl status mongodb
```

默认端口:  27017

## 二 使用

1. 基础命令

   ```
   #进入命令行
   mongo
   #显示所有数据库
   show dbs
   #切换数据库
   use admin
   #退出
   quit()
   ```

2. 插入数据

   ```
   use admin
   db.restaurants.insert(
      {
         "borough" : "Manhattan",
         "cuisine" : "Italian",
         "name" : "Vella",
         "id" : "41704620"
      }
   )
   ```

3. 查询

   ```
   db.col.find()
   ```

4. 更新

   ```
   db.restaurants.update(
       { "name" : "Vella" },
       {
         $set: { "cuisine": "American (New)" },
         $currentDate: { "lastModified": true }
       }
   )
   ```

5. 删除

   ```
   #删除一个集合中的所有文档，传递一个空的条件文档即可
   db.restaurants.remove( { } )
   #删除一个集合
   db.restaurants.drop()
   ```

   

## 三 卸载

```
sudo systemctl stop mongodb
sudo apt purge mongodb
sudo apt autoremove
```

