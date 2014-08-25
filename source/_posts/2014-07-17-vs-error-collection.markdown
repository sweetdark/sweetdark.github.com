---
layout: post
title: "vs编译错误及解决办法"
date: 2014-07-17 18:18:48 +0800
comments: true
tags: Compile 
---

###error C2220: 警告被视为错误 - 没有生成“object”文件
这种错误的原因是：原因是该文件的代码页为英文，而我们系统中的代码页为中文。
解决方案：
1. 在VS2010以后在文件->高级保存选项，设置UTF-8的格式，重新保存一次。 或者用其它的程序保存成UTF-8的格式。
 
2. 如果上述不能去掉错误，还可以点击项目，右击选择属性->配置属性->c/c++->常规，将“警告视为错误”的选项改为“否”。就可以！
 

###error C2143: 语法错误 : 缺少“;”(在“类型”的前面)
C99之前都要求，函数内的局部变量要在开始处定义。
``` c
int f()
{
	int j = 5;
	printf("j is %d", j);
	int i = 3;
}
```
这可能出现在c文件编译的时候，VS2012都不完全支持C99。须要调整一下代码。把函数内的局部变量放到函数开头去定义。或者改成cpp后缀的文件

VS2010之后开始支持C99，所以在VS2008之前如果出现 找不到 stdint.h 文件的话。可以升级到VS2010之后。

###LNK2001: 无法解析的外部符号 __iob 问题的解决方法

1. 缺少libc.lib
解决这个问题的方法是去掉链接到libc.lib，具体地点：项目-〉属性-〉配置属性-〉链接器-〉忽略特定库。

2. unresolved external symbol `__iob`
这个`__iob`找不到的问题费了我大部分的时间。跟踪到stdio.h文件，发现那里有个关于iob的宏，终于搞定。加入一句话到.cpp文件中：`extern "C" { FILE _iob[3] = {__iob_func()[0], __iob_func()[1], __iob_func()[2]}; }`

3. NULL iterator
STL已经不能有NULL迭代器这么一说了，想想也对，在NULL迭代器上进行++或--之类的是不成立的。

4. 结构体默认函数
在VC6中，结构体的默认运算符==或者\<之类的如果不实现也可以作为STL元素放入list等容器中。但VC8不行了，因为它已经不再为结构体生成缺省的操作符函数。

 

该错误主要是由于静态库在VC6编译而主程序在VC2005编译，大家用的CRT不同。解决办法，代码中增加
``` c
#ifdef __cplusplus
extern "C"
#endif
FILE _iob[3] = {__iob_func()[0], __iob_func()[1], __iob_func()[2]};
```
此错误的产生根源：
在VC6的stdio.h之中有如下定义

``` c
_CRTIMP extern FILE _iob[];
#define stdin (&_iob[0])
#define stdout (&_iob[1])
#define stderr (&_iob[2])
```
stdin、stdout、stderr是通过查_iob数组得到的。所以，VC6编译的程序、静态库只要用到了printf、scanf之类的函数，都要链接_iob数组。

而在vc2005中，stdio.h中变成了
```
_CRTIMP FILE * __cdecl __iob_func(void);
#define stdin (&__iob_func()[0])
#define stdout (&__iob_func()[1])
#define stderr (&__iob_func()[2])
```
`_iob`数组不再是显式的暴露出来了，需要调用__iob_func()函数获得。所以vc6的静态库链接VC2005的C运行库就会找不到_iob数组.
通过重新定义
`FILE _iob[3] = {__iob_func()[0], __iob_func()[1], __iob_func()[2]};`
就把vc6需要用到的_iob数组搞出来了


