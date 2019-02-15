package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;

public interface DogService {
	
	public List <Dog> index();
	public Dog show(Integer id);
	public void delete(Integer id);
	public Dog create(Dog dog, int userId);
	public Dog update(Dog dog);
	public List<Dog> getAllDogsByUserId(Integer id);
	public List<Dog> findByNameLike(String name);
	public List<Dog> findByBreedLike(String breed);
	
	
	

}
