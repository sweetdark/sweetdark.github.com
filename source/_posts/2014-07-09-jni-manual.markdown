---
layout: post
title: "JNI Manual GetFieldID"
date: 2014-07-09 21:32:08 +0800
comments: true
tags: JNI
---
在JNI中要访问结构体中的字段，首先要获得这个字段的FieldID。然后通过Get<Type>Field和Set<Type>Field来访问和修改。
``` c
//C的接口
jfieldID GetFieldID(JNIEnv *env, jclass clazz,
		const char *name, const char *sig);

//C++的接口
jfieldID GetFieldID(jclass clazz, const char *name, const char *sig);

```
**描述** 
> 返回一个字段的FieldID或者为NULL（如果操作失败），这个字段是用字段和描述串来指定的。然后把FieldID作为Get<Type>Field和Set<Type>Field的参数来访问这个字段。这个字段必须是可以通过clazz来访问的. 当然这个字段可以是clazz类的父类, clazz必须是非空的。
> GetFieldID会初始化未初始化的类
> GetFieldID不可以用来获取数组的长度。应该用GetArrayLength来获取数组的长度。

**异常**
> NoSuchFiledError: 如果指定的字段没有找到
> ExceptionInInitializeError: 如果类初始化失败。
> OutOfMemoryError：系统内存不够

``` java Java结构体Person.java
public class Person
{
	String name;
	int ID;
	public native Person OnePerson();
}

```
``` c 本地方法的实现
JNIEXPORT jobject JNICALL Java_Person_OnePerson
  (JNIEnv *, jobject)
{

}
```
