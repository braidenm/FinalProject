package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dislike;
import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.repositories.DislikeRepo;
import com.skilldistillery.doggyTinder.repositories.DogRepo;


@Service
public class DislikeServiceImpl implements DislikeService {

	
	@Autowired
	private DislikeRepo dRepo;
	@Autowired
	private DogRepo dogRepo;

	
	@Override
	public Dog addDislike(Integer thisDog, Integer thatDog) {
		Optional<Dog> op = dogRepo.findById(thisDog);
		Optional<Dog> op2 = dogRepo.findById(thatDog);
		Dislike dislike = new Dislike();
		if(op.isPresent() && op2.isPresent()) {
			dislike.setThatDog(op2.get());
			dislike.setThisDog(op.get());
			dRepo.saveAndFlush(dislike);
			Dog dog = op.get();
			dog.addDislike(dislike);
			dogRepo.saveAndFlush(dog);
			return dog;
		}
		return null;
	}

	@Override
	public List<Dislike> getAllDislikesByThisDog(Integer dogId) {
		return dRepo.findByThisDog_id(dogId);
	}

	@Override
	public List<Dislike> getAllDislikes() {
		return dRepo.findAll();
	}

	@Override
	public List<Dislike> getAllDislikesByThatDog(Integer dogid) {
		// TODO Auto-generated method stub
		return dRepo.findByThatDog_id(dogid);
	}

}
