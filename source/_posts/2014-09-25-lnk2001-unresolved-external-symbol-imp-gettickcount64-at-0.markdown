---
layout: post
title: "LNK2001: unresolved external symbol __imp__GetTickCount64@0"
date: 2014-09-25 22:16:46 +0800
comments: true
tags: compile
---
这个链接错误的发生在链接MSVCRT.lib时，原因是链接了的错误版本kernel32.lib等库。修改link条件，把/LIBPATH:"libpath"这个改为正确的path就可以了。如果自己写makefile文件，在使用编译器，链接器，头文件，和库时，要特别小心。如果使用了第三方的库要看这个第三方的库是用什么版本的CRT（运行时库）编译的，是多线程版的还是单线程版的，用Unicode的还是ASCII的。

**LINK : fatal error LNK1101: incorrect MSPDB80.DLL version;** 这个错误是在使用cl.exe命令行编译时出现的错误，原因是VC\Bin\下没有“msobj80.dll,mspdb80.dll,mspdbcore.dll,mspdbsrv.exe”这四个文件。
解决的方法：

* 直接从Common7\IDE\下复制这四个文件到VC\Bin\下即可解决
* 添加系统变量(Path)，这样：我的电脑->属性->高级->环境变量->系统变量，在path中添加C:\Program Files\Microsoft Visual Studio 8\Common7\IDE；，注意结尾最后用“；”隔开！

附注：
> 
> RUN-TIME LIBRARYRun-Time Library是编译器提供的标准库，提供一些基本的库函数和系统调用。
> 我们一般使用的Run-Time Library是C Run-Time Libraries。当然也有Standard C++ libraries。
> 
> C Run-Time Libraries实现ANSI C的标准库。VC安装目录的CRT目录有C Run-Time库的大部分源代码。 C Run-Time Libraries有静态库版本，也有动态链接库版本；有单线程版本，也有多线程版本；还有调试和非调试版本。
> 
> 动态链接库版本：/MD Multithreaded DLL 使用导入库MSVCRT.LIB
> 
> /MDd Debug Multithreaded DLL 使用导入库MSVCRTD.LIB
> 
> 静态库版本：/ML Single-Threaded 使用静态库LIBC.LIB
> 
> /MLd Debug Single-Threaded 使用静态库LIBCD.LIB
> 
> /MT Multithreaded 使用静态库LIBCMT.LIB
> 
> /MTd Debug Multithreaded 使用静态库LIBCMTD.LIB
> 
> 若要使用其中的一个运行时库 请忽略其他库：
> 
> * libc.lib 单线程 libcmt.lib、msvcrt.lib、libcd.lib、libcmtd.lib、msvcrtd.lib
> * libcmt.lib 多线程 libc.lib、msvcrt.lib、libcd.lib、libcmtd.lib、msvcrtd.lib
> * msvcrt.lib 使用多线程 DLL libc.lib、libcmt.lib、libcd.lib、libcmtd.lib、msvcrtd.lib
> * libcd.lib 单线程调试 libc.lib、libcmt.lib、msvcrt.lib、libcmtd.lib、msvcrtd.lib
> * libcmtd.lib 多线程调试 libc.lib、libcmt.lib、msvcrt.lib、libcd.lib、msvcrtd.lib
> * msvcrtd.lib 使用多线程调试 DLL  libc.lib、libcmt.lib、msvcrt.lib、libcd.lib、libcmtd.lib
> 
> 设置方法：属性，链接器，输入，忽略指定库 libc.lib、libcmt.lib、msvcrt.lib、libcd.lib、libcmtd.lib （使用一个，忽略其他的）

[1] 引用http://www.hz601.org/heaven/
