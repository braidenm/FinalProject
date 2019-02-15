package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.User;
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
		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	@Override
	public void delete(Integer id) {
		Optional<Dog> op = dRepo.findById(id);
		if (op.isPresent()) {
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
		Optional<User> op = uRepo.findById(userId);
		try {
			if (op.isPresent()) {
				dog.setUser(op.get());
				dog.setPreferences(null);
				dRepo.saveAndFlush(dog);
				return dog;
			}
			System.out.println("invalid user");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Dog update(Dog dog) {
		Optional<Dog> op = dRepo.findById(dog.getId());
		try {
			if (op.isPresent()) {
				Dog managed = op.get();
				managed.setAbout(dog.getAbout());
				managed.setAge(dog.getAge());
				managed.setName(dog.getName());
				managed.setBreed(dog.getBreed());
				managed.setWeight(dog.getWeight());
				managed.setEnergy(dog.getEnergy());
				managed.setAbout(dog.getAbout());
				managed.setPhotos(dog.getPhotos());
				dRepo.saveAndFlush(managed);
				return managed;
			}
			System.out.println("invalid dog");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<Dog> getAllDogsByUserId(Integer id) {
		Optional<User> uOp = uRepo.findById(id);
		try {
			if(uOp.isPresent()) {
				User user = uOp.get();
				return user.getDogs();
			}
			System.out.println("invalid user. Error at DogServiceImpl.getAllDogsByUserId");
			return null;
		}catch(Exception e ) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<Dog> findByNameLike(String name) {
		return dRepo.findByNameLike("%"+name+"%");
	}

	@Override
	public List<Dog> findByBreedLike(String breed) {
		return dRepo.findByBreedLike("%"+breed+"%");
	}
	
	

}
