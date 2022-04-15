package com.lec.ex3_quiz;

public class Person {
	private String name;
	private String tel;
	private int age;

	public Person() {}
	public Person(String name, String tel, int age) {
		super();
		this.name = name;
		this.tel = tel;
		this.age = age;
	}

	@Override
	public String toString() {
		return name + "\t" + tel + "\t\t" + age + "\n";
	}

}
