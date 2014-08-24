---
layout: post
title: "Andriod ndk error local reference table overflow Max 512"
date: 2014-07-09 12:57:43 +0800
comments: true
tags: JNI 
---
#引言
在Android开发中，常会遇到 local reference table overflow的错误。原因是从java代码进入jni层的本地代码调用时，Dalvik就会创建一张local reference表来存储local reference， 这张表的表项数有最大限制。一般为512个。当表项数超过最大值限制时，Dalvik就会抛出异常。

``` c 下面这段代码就会导致溢出
	jclass strinClass = NULL;
	for (int i = 0; i < 800; i++)
	{
		stringClass = env->FindClass("java/lang/String");
		.....
	}
```

#什么是Local References？
大多数的JNI函数都创建了Local reference（以下简称为*LR*）。 比如 NewObject, NewString.... 和 FindClass 等。

一个*LR*只有在创建它的的一个局部作用域内有效。在超出这个作用域之后，就可能会被释放。 所有的*LR*在本地函数调用时创建的，在这个本地函数返回时就会被释放。

你不能把一个Local reference 保存在静态变量中，然后在后面继续调用，这是不安全的。

``` c 错误的例子
/* This code is illegal */
jstring
MyNewString(JNIEnv *env, jchar *chars, jint len)
{
    static jclass stringClass = NULL;
    jmethodID cid;
    jcharArray elemArr;
    jstring result;
    if (stringClass == NULL) {
        stringClass = (*env)->FindClass(env,
                                        "java/lang/String");
        if (stringClass == NULL) {
            return NULL; /* exception thrown */
        }
    }
    /* It is wrong to use the cached stringClass here,
       because it may be invalid. */
    cid = (*env)->GetMethodID(env, stringClass,
                              "<init>", "([C)V");
    ...
    elemArr = (*env)->NewCharArray(env, len);
    ...
	result = (*env)->NewObject(env, stringClass, cid, elemArr);
    (*env)->DeleteLocalRef(env, elemArr);
    return result;
}

JNIEXPORT jstring JNICALL
Java_C_f(JNIEnv *env, jobject this)
{
	char *c_str = ...;
	return MyNewString(c_str);
}

//Java 中
... = C.f();
... = C.f();
```
假设我调用了两次Java\_C\_f。 其中调用了MyNewString， MyNewString的想法是把stringClass这个*LR* 初始化一次后保存起来，下次可以继续用。但根据JNI的规则。在MyNewString返回时，所有的*LR*都会被释放。所以第二次调用时stringClass就是Invalid的。

虽然VM会在本地函数返回时，释放所有的*LR*，但我们也可以显示的控制*LR*的释放。*LR*引用的对象只有在，*LR*无效的时候才会被GC回收，在MyNewString函数中调用的DeleteLocalRef 释放中间的变量elemArr，这样GC可以立即回收这个*LR* 不然elemArr这个*LR*会等到本地函数MyNewString返回时才被回收。

*LR*只能在创建它的线程中使用，在其它的线程中使用它是错误的。所以用一个全局变量保存在其它线程中用是不可行的。
<!--more-->
##释放引用
```
//1.FindClass 

//例如，

jclass ref= (env)->FindClass("java/lang/String");

env->DeleteLocalRef(ref); 

 

2.NewString/ NewStringUTF/NewObject/NewByteArray

//例如，

jstring     (*NewString)(JNIEnv*, const jchar*, jsize);    

const jchar* (*GetStringChars)(JNIEnv*, jstring, jboolean*);     

void        (*ReleaseStringChars)(JNIEnv*, jstring, const jchar*);

jstring     (*NewStringUTF)(JNIEnv*, const char*);    

const char* (*GetStringUTFChars)(JNIEnv*, jstring, jboolean*);     

void        (*ReleaseStringUTFChars)(JNIEnv*, jstring, const char*);

env->DeleteLocalRef(ref);

 

3. GetObjectField/GetObjectClass/GetObjectArrayElement

jclass ref = env->GetObjectClass(robj);

env->DeleteLocalRef(ref); 

 

4.GetByteArrayElements

jbyte* array= (*env)->GetByteArrayElements(env,jarray,&isCopy);

(*env)->ReleaseByteArrayElements(env,jarray,array,0);

 const char* input =(*env)->GetStringUTFChars(env,jinput, &isCopy);

(*env)->ReleaseStringUTFChars(env,jinput,input);
```

##参考
1. [Local and Global References](http://journals.ecs.soton.ac.uk/java/tutorial/native1.1/implementing/refs.html)

2. [The Java ™  Native Interface Programmer’s Guide and Specification](http://www.soi.city.ac.uk/~kloukin/IN2P3/material/jni.pdf)

3. http://mysuperbaby.iteye.com/blog/1603817
