---
title: Gradle 优化
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


# AS优化

内存配置

```
-Xms512m
-Xmx2048m
-XX:MaxPermSize=768m
-XX:ReservedCodeCacheSize=768m
-XX:+UseCompressedOops

修改android-studio/bin/studio.vmoptions   studio64.vmoptions  两个文件的以下属性就可以了
-Xms1024m
-Xmx2048m
-XX:MaxPermSize=2048m
-XX:ReservedCodeCacheSize=1024m
```



# Gradle优化

```
# 开启Daemon
org.gradle.daemon=true

# 调整 daemon’s 的堆大小，默认是 1 GB
org.gradle.jvmargs=-Xmx2048M
org.gradle.jvmargs=-Xmx5120m -XX:MaxPermSize=2048m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```

```
# Configuration on demand开启(按需配置)
org.gradle.configureondemand=true

# 开启parallel(并行执行多项目编译提升编译速度)
org.gradle.parallel=true
```

