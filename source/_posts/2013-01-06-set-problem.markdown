---
layout: post
title: "set_problem"
date: 2013-01-06 21:17
comments: true
categories: 
---
集合问题：

cover(members, subsets, covering) {
	set *setd = (set*)malloc(sizeof(set));
	while (members.size > 0 && subsets.size >0) {
		set *h = subsets.head;
		set *p = 0;
		int max = 0;
		for (; h != NULL; h = h->next) {
			for (n = 0; n < members.size; n++) {
				int temp;
				if (set_ismember(h, members[n])) temp ++;
			}
			if (temp > max) {max = temp; p = h;}
		}
		set_remove(subsets, p);
		set_insert(covering, p);
		set_difference(setd, members, p);
		members = setd;
	
	}

}

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
}