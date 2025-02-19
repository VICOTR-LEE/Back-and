package com.lec.ex3_set;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

public class Ex04_Iterator {
	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList<String>();
		list.add("STR"); 
		list.add("STR");
		System.out.println(list);
		Iterator<String> it = list.iterator();
		while(it.hasNext()){
			System.out.println(it.next());
		}
		for(String l : list) {
			System.out.println(l);
		}
		// �� 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("ȫ�浿", "010-9999-9999");
		map.put("��浿", "010-9999-9999");
		Iterator<String> it2 = map.keySet().iterator();
		while(it2.hasNext()) {
			String key = it2.next();
			System.out.println(key + "Ű�� ������ : " + map.get(key));
		}
		// ��
		HashSet<String> set = new HashSet<String>();
		set.add("str0");
		set.add("str1");
		set.add("str2");
		Iterator<String> it3 = set.iterator();
		while(it3.hasNext()) {
			System.out.println(it3.next());
		}
	}
}
