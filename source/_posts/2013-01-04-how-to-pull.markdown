---
layout: post
title: "非本机快速写博客"
date: 2013-01-04 12:51
comments: true
categories: 
tags: ['Github','octopress']
---

有时出差，或者去别的地方。要在其他地方写博客怎么办呢。首先安装好机子上的本地环境。参考[这里](http://xuhehuan.com/783.html)的搭建本地环境和更新本地环境。然后从github中clone 远程的仓库到本地。
具体步骤：
git clone git://github.com/sweetdark/sweetdark.github.com.git octopress
进入该目录
cd octopress
你用git branch -a命令查看分支
你会发现只是clone了master的分支，没有克隆和创建source分支的。source的文件夹和文件没有克隆下来：
{% img http://p13.freep.cn/p.aspx?u=v20_p13_photo_1301041302488150_0.jpg %}

那么我们要从本地区抓取远程的source分支。
可以执行
git checkout --track -b reps-branch origin/reps-branch  抓取 reps-branch, 並將此 branch 建立於 local 的 reps-branch
再看一下你的目录：
{% img http://p13.freep.cn/p.aspx?u=v20_p13_photo_1301041303593154_0.jpg %}
是不是可以了。
附上全部命令截图：
{% img http://p13.freep.cn/p.aspx?u=v20_p13_photo_1301041304293434_0.jpg %}

写完博客发布之后，别忘了。
用git status检查哪些还没有提交，用git add . 和 git commit -m "yourmessage"提交更新
最后要git push origin source

一切搞定。