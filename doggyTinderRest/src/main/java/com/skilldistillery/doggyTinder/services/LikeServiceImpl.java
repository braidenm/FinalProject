package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.LikeRepo;

@Service
public class LikeServiceImpl implements LikeService{

	@Autowired
	private LikeRepo lRepo;
	@Autowired
	private DogRepo dRepo;
	
	
	
	@Override
	public Dog addlike(Integer thisDog, Integer thatDog) {
		Optional<Dog> op = dRepo.findById(thisDog);
		Optional<Dog> op2 = dRepo.findById(thatDog);
		Likes like = new Likes();
		if(op.isPresent() && op2.isPresent()) {
			like.setThatDog(op2.get());
			like.setThisDog(op.get());
			lRepo.saveAndFlush(like);
			Dog dog = op.get();
			dog.addLike(like);
			dRepo.saveAndFlush(dog);
			return dog;
		}
		return null;
	}

	@Override
	public List<Likes> getAllLikesByThisDog(Integer thisDog) {
		return lRepo.findByThisDog_id(thisDog);
	}

	@Override
	public List<Likes> getAllLikesByThatDogId(Integer thatDog) {
		return lRepo.findByThatDog_id(thatDog);
	}

	@Override
	public List<Likes> getAllLikes() {
		return lRepo.findAll();
	}

}
