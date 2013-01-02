---
layout: post
title: "博客主题的配置"
date: 2013-01-02 12:17
comments: true
categories: 
tags: ['Github','octopress']
---

**首先[我的博客主题](https://github.com/sweetdark/sweetdark.github.com/tree/source/.themes)下载。把mario目录拷贝到.themes目录下。执行rake install["mario"]** 由于categories不支持中文，我加了tags标签。
装完之后，要改一下_config.yml的配置，在适当的位置添加一行tag_dir: blog/tags  。然后在文章里，添加tags: 标签下面添你的标签名，例如：  tags: ['Github','octopress']
{% img http://p13.freep.cn/p.aspx?u=v20_p13_photo_1301021334145207_0.png %}

我还在导航栏理 添加了关于我的界面，修改的话，请修改about目录下的index.html文件即可。

关于在侧边栏添加微博插件的问题，我在\_includes\asides 下增加了weibo_sina.html只要修改这个文件，替换为你的微博Html代码。微博的html代码的，只要登录你的微博，在设置里，点击我的工具可以产生。
{% img http://p13.freep.cn/p.aspx?u=v20_p13_photo_1301021321353343_0.png %}
然后再_config.yml修改一下配置
default_asides: [asides/recent_posts.html, asides/github.html, asides/weibo_sina.html, asides/googleplus.html]  加上asides/weibo_sina.html即可。

编写markdown文件的工具可以使用[markdownPad](http://markdownpad.com/)，推荐使用notepad++编写博客，把经常使用的插件代码用宏录制好，避免重复性的工作。上传图片的工具可以使用http://www1.freep.cn/。