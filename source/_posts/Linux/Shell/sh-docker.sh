---
title: sh-docker
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Shell
tags: [linux,shell]
---

<meta name="referrer" content="no-referrer" />


## -i		 	安装指定的套件档
# -v 			显示指令执行过程
# -h或--hash 	套件安装时列出标记
# --force 		强行置换套件或文件
# --nodeps 		不验证套件档的相互关联性
# --allmatches	删除符合指定的套件所包含的文件
# -e  			删除指定的套件
#
rpm -ivh data/docker/catatonit-0.1.3-lp151.2.6.x86_64.rpm;
rpm -ivh data/docker/docker-libnetwork-0.7.0.1+gitr2711_2cfbf9b1f981-lp151.1.2.x86_64.rpm;
rpm -ivh data/docker/docker-runc-1.0.0rc6+gitr3748_96ec2177ae84-lp151.2.2.x86_64.rpm;
rpm -ivh data/docker/containerd-1.2.2-lp151.1.2.x86_64.rpm;
rpm -ivh data/docker/docker-18.09.1_ce-lp151.1.2.x86_64.rpm;
rpm -ivh data/docker/docker-zsh-completion-18.09.1_ce-lp151.1.2.noarch.rpm;
rpm -ivh data/docker/docker-bash-completion-18.09.1_ce-lp151.1.2.noarch.rpm;
# 卸载 rpm -e -v --allmatches docker
#
#
rcSuSEfirewall2 stop;
netstat -tunlp;