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


//伪代码
``` c
int cover(set *members, set *subsets, set **covering) {
	set *setd = (set*) malloc (sizeof(set));
	wile (list_size(members) > 0 && list_size(subsets) >0) {
		SetElement *pos = list_head(subsets);
		SetElement *max_pos = NULL;
		int max = 0;
		for (; pos != NULL; pos = list_next(pos)) {
			int temp = 0;
			SetElement *mems = list_head(members);
			for (; mems != NULL; mems = list_next(mems)) {
				if (set_ismember((set*)(list_data(pos)), mems) == 0) {
					++temp;
				}
			}
			if (temp > max) {
				max = temp;
				max_pos = pos;
			}
		}
		if (set_insert(*covering, max_pos) == -1) return -1;
		if (set_remove(subsets, max_pos) == -1) return -1;
		if (set_difference(setd, members, (set*)(list_data(max_pos))) == -1) return -1;
		members = setd;
	}
	if (list_size(members) == 0)  { free(setd); return 0;}
	if (list_size(members) > 0 && list_size(subsets) == 0) { free(setd); return 1; }
	free(setd);
	return -1;
 ```
}