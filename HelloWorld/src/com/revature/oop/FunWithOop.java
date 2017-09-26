package com.revature.oop;

import com.revature.oop.*;
public class FunWithOop {

	public static void main(String[] args) {
		
		Cat c1 = new Cat("Sue");
		System.out.println(c1.toString());
		Cat c2 = new Cat("Mike");
		System.out.println(c2.toString());
		
		Dog d1 = new Dog("Kathi");
		Dog d2 = new Dog("Bob");
		
		//instance method, so we get the overridden version
		c1.makeNoise();
		
		//static variable maxLives 
		
		System.out.println(c2.maxLives); //field should be accessed in a static way
		c2.maxLives = 10;
		System.out.println(c1.maxLives);//oh no! it changed for all the cats!
		
		Cat.maxLives = 9;
		
		//Put all of our animals into an array using polymorphism 
		/*
		 * Arrays:
		 * - Elements must be of the same type, length must be specified 
		 * - length is immutable (block of contiguous memory allocated at instantiation
		 * - all elements set to default value for that datatype 
		 * - java.util.Arrays (note the s) for useful methods
		 */
		
		Animal[] animalArray = new Animal[4];
		animalArray[0] = c1;
		animalArray[1] = c2;
		animalArray[2] = d1;
		animalArray[3] = d2;
		//traverse to print out 
		
		//cast between super- and sub- classes 
		((Animal)c1).makeNoise(); //this will still give the Cat version of makeNoise() due to overriding
		Animal a2 = (Animal) c2; //treating c2 as its parent class ("upcasting")
		/*
		 * This throws a ClassCastException because the actual type of a2 is Cat
		 */
		//Dog d3 = (Dog) a2; //"downcasting" from Animal to a subclass 
		
	}
}
