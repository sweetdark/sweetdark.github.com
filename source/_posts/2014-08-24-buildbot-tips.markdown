---
layout: post
title: "buildbot tips"
date: 2014-08-24 22:45:16 +0800
comments: true
tags: build
---
##目录
1. 命令最终执行的代码的目录是 build配置的slave builddir(没有则默认是slave的name) + step的workdir


##Scheduler
1. Dependant Scheduler只依赖于上层的Scheduler。当上层的Scheduler成功时，才会执行，而不关心其它的改变。须要注意的是如果ChangeSourcerevision为None，那这意味着Head revision。如果在上流的Scheduler执行成功后，触发Dependant的期间，ChangeSource发生了改变，那么Dependant会取最新的Head revision。 如果想要更灵活的方式，可以考虑用Triggerable Scheduler的方式

##Steps
1. steps中的SVN的checkout和update会先删掉checkout目录，然后重新checkout一份代码。所以不要在这个目录下放一些非SVN服务器上的东西。
2. steps中可以获得build设置的property，可以通过这些property来执行相应的代码。更灵活的方式是用render
3. steps可以设置Property来给下一个steps用，使用SetProperty(property="", value="") values可以是string和 Interpolate对象,这样就可以把一些steps根据property来执行
``` python 例子
from buildbot.steps.vstudio import vc8
from buildbot.process.properties import Property
from buildbot.process.factory import BuildFactory
from buildbot.steps.master import SetProperty

vc = vc8(projectfile="youproject.sln",
		mode="build",
		config=Property("buildconfig"))

build = BuildFactory()
build.addStep(SetProperty(property="buildconfig", value="release"))
build.addStep(vc)

```



