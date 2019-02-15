package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dog;

public interface DogRepo extends JpaRepository<Dog, Integer> {
	List<Dog> findByNameLike(String name);
	List<Dog> findByBreedLike(String Breed);
	//Below method to find by user Id or object, if doesn't work try other
	List<Dog> findByUserId(Integer id);	

}
