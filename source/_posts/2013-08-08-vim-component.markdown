---
layout: post
title: "vim 命令组合"
date: 2013-08-08 21:14
comments: true
categories: 
tags: vim
---
####以下的命令都是在非insert模式下执行的
#vim 与跳转命令的组合
```
dw 从光标处开始往后删除一个字
dW 从光标处开始往后删除一个长字
d$ 从光标处开始往后删除到行尾
d0 从光标处开始往前删除到行头
d^ 从光标处开始往前删除到第一个字符头
D  删除一整行
dnw 往后删除多个字符
dd 删除一行包含换行符
df* 删除到第一个出现*包括*字符的字符串.

<action>i<object> 对在object范围中的内容进行action操作
如：
di) 在删除当前光标匹配的括号中的字符
(i >= 3 && i < 5)  此时将删除括号内的内容，只留下括号
<action>a<object> 对object范围包含object进行action操作
da) 把括号也删除

同理适用于 yank的一切
yw 复制一个字
yy, ydw, yW, yf* ynf* yi) ya) 等等

同理也适用于v 可视模式
vw vW vf* vi) 等等
......

```
#与寄存器的组合
```
"byy 把一行复制到寄存器b
"bp 粘贴寄存器b的内容
同理适用于 [a-zA-Z]的寄存器
```
#重复命令
```
. 重复执行上一次操作
@a 执行寄存器a记录的操作
@@ 执行寄存器的操作
n@@ 执行多次
```

#录制宏
```
qa 开始记录操作 保存到寄存器a
....
q 在非insert 模式下完成记录

@a 执行寄存器a中的操作
```
