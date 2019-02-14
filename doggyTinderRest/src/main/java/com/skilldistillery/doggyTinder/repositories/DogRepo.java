package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dog;

public interface DogRepo extends JpaRepository<Dog, Integer> {
	List<Dog> findByNameLike(String name);
	List<Dog> findByBreedLike(String Breed);
	

}
