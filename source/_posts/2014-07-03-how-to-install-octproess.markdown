---
layout: post
title: "如何部署已有的octopress Blog"
date: 2014-07-03 17:06:14 +0800
comments: true
tags: tools
---
1. 下载和安装git， 把git安装目录的bin和cmd文件目录加到path中。
2. 下载和安装ruby1.9.3，安装时可以勾选 加到path中。 安装完成后可以通过ruby --version来测试是否安装成功
3. 去网上下载一个[DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe](https://github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe) 解压到一个目录。dos cd 到这个目录。执行如下命令:
```
ruby dk.rb init 
ruby dk.rb install
```
博客的代码高亮需要python环境的支持。去下个python2.7安装。python 安装完成后。执行下面的命令

```
easy_install pygments
```

##设置本地环境

为了支持中文UTF-8编码，在Windows的环境变量中增加下面的选项。
```
LANG = zh_CN.UTF-8
LC_ALL = zh_CN.UTF-8
```

- 配置git
```
git config --global user.name "yourname"
git config --global user.email "youremail"
```

更新gem的更新源，ruby的官方网站经常被和谐。换成国内的更新源，这样速度就快多了，变更如下：
```
gem sources -a http://ruby.taobao.org/
gem sources -r http://rubygems.org/
```

##下载并配置Blog
在某个目录下，DOS命令
```
git clone git@github.com:sweetdark/sweetdark.github.com.git sweetdark

如果clone下来只有master分支，那可以新建个source分支，
git checkout -b source 
这个命令会新建source分支并切换到source分支。
再执行git pull origin source 把远程的github上source分支拉到本地source分支。

cd sweetdark
gem install bundler
bundle install
```

配置好之后，DOS cd 到sweetdark目录下就可以写blog了。请确保你在source 分支下，通过git branch 命令可以查看。你在哪个分支下。 git checkout source 可以切换到source分支
```
rake new_post["title"] #创建个新的文章，在source/_post目录下，打开它，就可以编辑了。

编辑完保存之后。
rake generate #生成网页
rake preview #预览 打开127.0.0.1:4000 可以看到。
rake deploy #发布

然后记得提交，须要权限，要ssh的private key。
git add .
git commit -m "your commit message"
git push origin source

```
git remote -v 命令可以查远程的地址。
![](../images/gitremote.png)
有不懂的git命令都可以用git command --help 来查这个command。


为了确保安全不造成混乱，以后每次写blog之前，都要检查，你是否是在source分支下，是否跟服务器上是一致的。
```
git checkout source #切换到source分支
git pull origin source #更新服务器上的内容到本地
```

##注意事项
- 图片最好是上传到一些可以保存图片的网站上，然后用 octopress 的Image 标签来引用， 相关用法http://octopress.org/docs/plugins/image-tag/。
用markdown语法也是可以的，不要写本地的相对路径（如上面的那张图片，会导致在Tag目录下看不到

相关的文章
octopress+github 构建blog [在Github上搭建Octopress博客](http://xuhehuan.com/783.html)

http://octopress.org/ 官方文档必看。这里有许多官方的plugin介绍。包括代码高亮，插入网络上图片等。

[MarkDonw的语法，文章就是用markdown语法的，很简单。](http://qingbo.net/picky/502-markdown-syntax.html)

-git的学习 

英文10本
http://sixrevisions.com/resources/git-tutorials-beginners/#comments 

中文

http://gitbook.liuhui998.com/index.html 

详解系列
http://blog.jobbole.com/24379/ 
http://blog.jobbole.com/25808/ 
