---
layout: post
title: "多个github用户配置SSH KEY的切换"
date: 2014-07-05 17:01:53 +0800
comments: true
tags: git 
---
如果你在github有多个帐户。那要在不同的帐户之间切换SSH Key。可以config来配置SSH key
假设你有两个private key文件为 id\_rsa1 和 id\_rsa2
生成ssh key的命令如下:
``` 
ssh-keygen -t rsa -C "youremail"
```
在git bash下
``` 
cd ~/.ssh
touch config
#打开config 如果你用的是vim 可以 vim config 

```
打开后编辑如下：
``` 
Host firstkey 
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa1
Host secondkey
	HostName github.com
	User git
	IdentityFile ~/.ssh/id_rsa2
```
**注意 Host是你的 git的SSH地址对应的地址。 也就是说 git@firstkey:yourname/your.git  这样就会找到Host 为firstkey的key了**
只需要把原先的git@github.com 改为git@firstkey 就可以了,更改远程地址的命令：
``` 
git remote set-url [name] [url]
git remote set-url --push [name] [url]
```
还要把key加入到ssh-agent中，命令如下:
``` 
ssh-add ~/.ssh/id_rsa1
ssh-add ~/.ssh/id_rsa2
#该命令如果报错：Could not open a connection to your authentication agent.无法连接到ssh agent
#可先执行
eval "ssh-agent -s" 或者 ssh-agent bash
```
例子：
``` sh 在同一机器不同目录下克隆远程同一个repo
git clone git@firstkey:xxx.git

git clone git@secondkey:xxx.git
```
上面的两条clone命令，虽然关联到同一个repo，却是通过不同ssh连接，当然也是不同的git账号。

