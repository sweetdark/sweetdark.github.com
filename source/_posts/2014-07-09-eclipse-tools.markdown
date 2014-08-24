---
layout: post
title: "Eclipse 工具"
date: 2014-07-09 19:33:01 +0800
comments: true
tags: tools 
---
##配置Javap工具
在Eclipse的Menu中打开Run\->External Tools\->External Tools Configurations
添加一个新的项。
{% img https://farm3.staticflickr.com/2928/14617040064_088658d740_o.png %}
{% img https://farm3.staticflickr.com/2912/14639067183_6776a117b8_b.jpg %}
javap这个工具可以用来输出java类 对应jni的描述。
{% img http://farm3.staticflickr.com/2939/14619183735_dfb1841c44_b.jpg %}
把Signature 后面的字符串拷贝就行了（**后面的分号也要拷贝**）。这样可以在GetField中使用了。
env->GetField(cls, "fieldName", "Signature");
javah的工具配置类似。

##定位文件目录
跟VS一样，VS在标签中右键打开文件目录一样。Eclipse须要配置。也是在External Tool中。
新建一个
{% img http://farm3.staticflickr.com/2931/14618685852_2340a8acab_b.jpg %}
Build选项下面就不要勾上build before launch了。

[Eclipse快捷键 10个最有用的快捷键](http://www.open-open.com/bbs/view/1320934157953/)

