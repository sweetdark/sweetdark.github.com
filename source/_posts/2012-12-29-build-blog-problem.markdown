---
layout: post
title: "搭建博客遇到的问题以及总结"
date: 2012-12-29 19:55
comments: true
categories: Technology
---
  使用octorepss+github搭建博客，在这个过程中遇到了很多问题。其实根本原因是自己过于浮躁，没有详细的研究文档，很匆忙的搭建，并乱改乱折腾，所以到处碰壁。Linux下搭建参考官方文档
  关于Windows下如何搭建octopress博客这篇文章讲的挺详细的。<a href="http://xuhehuan.com/783.html" title="在Github上搭建Octopress博客">在Github上搭建Octopress博客</a>
第一个遇到的问题：
{% img http://ww1.sinaimg.cn/mw690/7485f70fjw1e00h3kzw2cj.jpg %}

  我是在windows上装的，但是我按照octopress官网上的Linux的方式去装，装了ruby 1.9.3然后又按照<a href="http://xuhehuan.com/783.html" title="在Github上搭建Octopress博客">在Github上搭建Octopress博客</a>上介绍的windows的方式去装，结果导致了版本不一致的问题，建议版本最好是按照文章中建议的来装。如果装错了呢，怎么办。会提示版本对应不上的情况，可以修改Gemfile和Gemfile.lock下面的配置，设置到对应的版本号。
{% codeblock Gemfile %}
group :development do
  gem 'rake', '~> 10.0.3' #改为你所用的rake版本
  gem 'rack', '~> 1.4.1'
  gem 'jekyll', '~> 0.11.2'
  gem 'rdiscount', '~> 1.6.8'
  gem 'pygments.rb', '~> 0.2.12'
  gem 'RedCloth', '~> 4.2.9'
  gem 'haml', '~> 3.1.6'
  gem 'compass', '~> 0.12.1'
  gem 'rubypants', '~> 0.2.0'
  gem 'rb-fsevent', '~> 0.9'
  gem 'stringex', '~> 1.4.0'
  gem 'liquid', '~> 2.3.0'
end
{% endcodeblock %}
{% codeblock %}
    rake (10.0.3)  #改为你所用的rake版本
{% endcodeblock %}
  如果是发布不成功，没有权限报错如下：那么就是没有添加ssh key。详细解决办法是添加一个ssh key。

{% img http://ww1.sinaimg.cn/mw690/7485f70fjw1e04hxitgftj.jpg %}


详细参考这里https://help.github.com/articles/generating-ssh-keys 。
有一点要注意的是Octopress会有两个分支：source（编写博客）和master（生成好的博客）。一般我们用source编写博客，和使用rake generate生成博客。rake deploy是发布到远程的origin master主分支上的。请不要在本地仓库上对master进行编辑，添加，修改等操作，更不要使用git push origin master用本地仓库的master去同步远程的github仓库。你会遇到很多麻烦的，我就是瞎折腾，所以就弄得半死。我建议的操作方式是：步骤如下：

	1. git checkout source 切换到source分支上，进行编辑
	2. pull origin source 从远程仓库获取最新的并与本地仓库进行合并(如果你是在其他的电脑上工作，这一步很重要），你也可以这样用git fetch orgin source,git merge 。
	3. 编辑好博客之后使用 rake gen_deploy可以生成并发布，但不建议这样做，你可以先rake generate，然后用rake preview先在本地预览一下，觉得没问题了在rake deploy发布。
	4. 发布完了，别忘记备份到github上。首先git status 检查本地仓库的状态，这时会打印列表并给出相应的指令，然后调用 git add 命令添加你新增的文件，或者合并解决冲突之后的文件。调用git commit -m "yourmessage" 提交。
	最后再用git status确认一下，确认无误之后git push origin source，备份到github上。

<!-- more -->
关于github的一系列教程，推荐几篇文章。
git入门 http://rogerdudler.github.com/git-guide/index.zh.html

<a href= "http://blog.jobbole.com/25775/">git 详解系列</a>

<a href="http://blog.longwin.com.tw/2009/05/git-learn-initial-command-2009/">git命令详解</a>

http://blog.jobbole.com/23398/ git管理策略。

附加一些自己遇到的问题：


{% img http://img.my.csdn.net/uploads/201212/29/1356783166_1307.png %}


解决办法stackoverflow有人给出。http://stackoverflow.com/questions/2452226/master-branch-and-origin-master-have-diverged-how-to-undiverge-branches

{% img http://img.my.csdn.net/uploads/201212/29/1231245.jpg %}

改变远程的仓库的地址请看这里https://help.github.com/articles/changing-a-remote-s-url
