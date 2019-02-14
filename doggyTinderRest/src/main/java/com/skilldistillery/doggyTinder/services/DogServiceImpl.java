package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.UserRepo;



@Service
public class DogServiceImpl implements DogService {

	@Autowired
	private DogRepo dRepo;
	
	@Autowired
	private UserRepo uRepo;
	
	
	@Override
	public List<Dog> index() {
		return dRepo.findAll();
	}

	@Override
	public Dog show(Integer id) {
		
		Optional<Dog> op = dRepo.findById(id);
		if(op.isPresent()) {
			return op.get();
		}
		return null;
	}

	@Override
	public void delete(Integer id) {
		Optional<Dog> op = dRepo.findById(id);
		if(op.isPresent()) {
			Dog dog = op.get();
			dog.setPhotos(null);
			dog.setPreferences(null);
			dog.setMessages(null);
			dog.setLikes(null);
			dog.setDislikes(null);
			dog.setMatches(null);
			dRepo.saveAndFlush(dog);
			dRepo.deleteById(id);
		}
	}

	@Override
	public Dog create(Dog dog, int userId) {
		dog.setActive(true);
		dRepo.saveAndFlush(dog);
		return dog;
	}

	@Override
	public Dog update(Dog dog) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dog> getAllDogsByUserId(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dog> findByNameLike(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dog> findByBreedLike(String Breed) {
		// TODO Auto-generated method stub
		return null;
	}

}
