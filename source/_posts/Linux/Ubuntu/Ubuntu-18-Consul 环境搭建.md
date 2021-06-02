1 下载

​	官网 https://www.consul.io/downloads

​	中文官网 https://kingfree.gitbook.io/consul/getting-started/agent

2 启动

```
# 开发服务器模式
consul.exe agent -dev
# 远程可以访问 
consul.exe agent -dev -ui -node=my-test-consul -client 0.0.0.0

# agent 运行一个consul agent
# -dev dev表示开发模式运行，另外还有-server表示服务模式运行
# -ui 启用内置的Web UI服务器和所需的HTTP路由
# -node=my-test-consul	集群中此节点的名称。这在集群内必须是唯一的。默认情况下，这是机器的主机名
# -client 指定客户端访问的地址。默认是“127.0.0.1”，使用0.0.0.0绑定所有客户端地址
```

```
# 服务器模式
consul.exe agent -server -ui -bind=127.0.0.1 -data-dir /tmp/consul
# 生产环境
consul agent -server -bootstrap-expect 1 -datacenter=ysdc -data-dir ./consul -node=consul-server -bind=127.0.0.1

# agent  	运行一个consul agent
# -server   dev表示开发模式运行，另外还有-server表示服务模式运行
# -ui   	显示ui页面
# -bind	 	节点名称
# -data-dir 
```

3 常用命令

```
# 已注册服务
curl http://localhost:8500/v1/catalog/services

#json 格式化
curl http://localhost:8500/v1/catalog/services | python -m json.tool
```

