---
layout: post
title: "集合覆盖问题"
date: 2013-01-06 21:17
comments: true
categories: 
tags: ['算法与数据结构']
---
##概述
集合覆盖问题(Set Covering Problem，简称SCP)是经典的NP一hard问题，同样也是运筹学研究中典型的组合优化问题，是一个计算机科学问题的典型代表。
问题如下定义：首先有一个元素集合U，给定一系列集合，各集合之中含可能有一些共同的元素（如图所示）。要求访问最少的集合，可以得到U中所有的元素，求出满足要求的最少数量的集合，它是Karp’s 21个NP-complete问题之一。

可以给出公式定义：

给定一个元素集合{U}和集合{﻿﻿﻿S}，Si中的元素属于U，即S是U的子集集合。我们要求的一个覆盖就是一个集合C，C是由si组成的 其元素集合之并等于U即
{% img right http://datasearch.ruc.edu.cn/~boliangfeng/blog/wp-content/uploads/2010/01/1.gif %}

用图示表明：
输入：元素集合{U},包含各个子集的集合{S}

{% img http://datasearch.ruc.edu.cn/~boliangfeng/blog/wp-content/uploads/2010/01/set-cover-L.gif %}

输出：一个集合C（C的子集是S的子集一种组合方案），覆盖了所有集合U中的元素。

{% img http://datasearch.ruc.edu.cn/~boliangfeng/blog/wp-content/uploads/2010/01/set-cover-R.gif %}

##问题实例
现在有好多不同种类的糖果，不过它们并不是单独出售的，它们按照不同的搭配被包装成不同的糖果包，并且不同的糖果包有不同的价格。若要得到所有类型的糖果，找到一个解决购买方案很容易，我们可以把所有的糖果包都购买一个。然而找到购买最少的糖果包或者找到花钱最少的购买方案将比较困难。找出较优的方案，尽可能的购买少量的糖果包，又能把所有种类的糖果都买到。

##贪婪近似算法
贪心算法（又称贪婪算法）是指，在对问题求解时，总是做出在当前看来是最好的选择。也就是说，不从整体最优上加以考虑，他所做出的仅是在某种意义上的局部最优解。贪心算法不是对所有问题都能得到整体最优解，但对范围相当广泛的许多问题他能产生整体最优解或者是整体最优解的近似解。

转化为糖果的问题就是，每一次挑选的糖果包能覆盖的糖果种类最多，则选择这个糖果包，直到覆盖所有的糖果种类为止。


##实现文件
``` c
#include "set.h"
#include <stdio.h>
/* subsets里存的是Set* 指针数据。 （已经测试）*/
int cover(Set *members, Set *subsets, Set *covering) {
  Set *setd = (Set*) malloc (sizeof(Set));
  while (list_size(members) > 0 && list_size(subsets) >0) {
      SetElement *pos = list_head(subsets);
      SetElement *max_pos = NULL;
      int max = 0;
      for (; pos != NULL; pos = list_next(pos)) {
          int temp = 0;
          SetElement *mems = list_head(members);
          for (; mems != NULL; mems = list_next(mems)) {
              if (set_ismember((Set*)(list_data(pos)), list_data(mems)) == 1) {
                  ++temp;
              }
          }
          if (temp > max) {
              max = temp;
              max_pos = pos;
          }
      }

      if (set_insert(covering, max_pos->data) == -1) return -1;
      void *data = max_pos->data;
      if (set_remove(subsets, (void**)&data) == -1) return -1;//max_pos这个SetElement已经被释放，但data还在。不能再用max_pos->data了。
      
      if (set_difference(setd, members, (Set*)(data)) == -1) return -1;
      members = setd;
  }
  if (list_size(members) == 0)  { free(setd); return 0;}
  if (list_size(members) > 0 && list_size(subsets) == 0) { free(setd); return 1; }
  free(setd);
  return -1;

}


void print(Set *set) {
    SetElement *elem;
    for (elem = list_head(set); elem != NULL; elem = list_next(elem)) {
        printf("%p\t", list_data(elem));
    }
    printf("\n");
}


int match(const void *data1, const void *data2) {
    const int *id1 = (const int*)data1;
    const int *id2 = (const int*)data2;
    if (*id1 > *id2) return 1;
    else if (*id1 < *id2) return -1;
    return 0;
}

int matchptr(const void *data1, const void *data2) {
    if (data1 == data2) return 0;
    return -1;
}

int main()
{
    Set *set1 = (Set*)malloc(sizeof(Set));
    Set *set2 = (Set*)malloc(sizeof(Set));
    Set *set3 = (Set*)malloc(sizeof(Set));
    Set *set4 = (Set*)malloc(sizeof(Set));
    Set *covers = (Set*)malloc(sizeof(Set));
    Set *allElem = (Set*)malloc(sizeof(Set));

    set_init(set1, match, NULL);
    set_init(set2, match, NULL);
    set_init(set3, match, NULL);
    set_init(set4, match, NULL);
    set_init(allElem, match, NULL);
    set_init(covers, match, free);
    int all[] = {1,2,3,4,5,6};
    int arr1[] = {3,4,1};
    int arr2[] = {4,5,1};
    int arr3[] = {2,6};
    int arr4[] = {1,3,4,5};
    int i;
    for (i = 0; i < 6; i++) {
        set_insert(allElem, (const void*)(all + i));
    }
    for (i = 0; i < 3; i++) {
        set_insert(set1, (const void*)(arr1 + i));
        set_insert(set2, (const void*)(arr2 + i));
    }
    for (i = 0; i < 2; i++) {
        set_insert(set3, (const void*)(arr3 + i));
    }
    for (i = 0; i < 4; i++) {
        set_insert(set4, (const void*)(arr4 + i));
    }

    Set *subsets = (Set*)malloc(sizeof(Set));
    set_init(subsets, matchptr, free);
    printf("%d\n",set_insert(subsets, set1));
    printf("%d\n",set_insert(subsets, set2));
    printf("%d\n",set_insert(subsets, set3));
    printf("%d\n",set_insert(subsets, set4));
    print(subsets);
    i = cover(allElem, subsets, covers);
    
    print(covers);
    
    set_destory(set1);
    set_destory(set2);
    set_destory(set3);
    set_destory(set4);
    set_destory(allElem);
    set_destory(covers);
    set_destory(subsets);

    return 0;

}
```

集合的数据结构在此博文已给出 http://sweetdark.github.com/blog/2013/01/04/set/ 
Makefile文件：
``` makefile
OBJS = list.o set.o set_cover.o
CC = gcc
CFLAGS =-Wall -O -g
prog: $(OBJS)
	gcc $(CFLAGS) $(OBJS) -o $@
 
list.o: list.c list.h
	gcc $(CFLAGS) -c $< -o $@
	
set.o: set.c set.h
	gcc $(CFLAGS) -c $< -o $@
	
set_cover.o: set_cover.c
	gcc $(CFLAGS) -c $< -o $@
	
.PHONY : clean
clean: 
	rm *.o
	rm prog.exe
```


