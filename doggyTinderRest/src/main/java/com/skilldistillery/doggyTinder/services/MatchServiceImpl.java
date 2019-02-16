package com.skilldistillery.doggyTinder.services;

import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.deser.DataFormatReaders.Match;
import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Matches;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.MatchRepo;
@Service
public class MatchServiceImpl implements MatchService {

	@Autowired
	private MatchRepo mRepo;
	@Autowired
	private DogRepo dogRepo;
	
	
	@Override
	public Dog addMatch(Integer thisDog, Integer thatDog) {
		
		Optional<Dog> op = dogRepo.findById(thisDog);
		Optional<Dog> op2 = dogRepo.findById(thatDog);
		Matches match = new Matches();
		if(op.isPresent() && op2.isPresent()) {
			Dog dog = op.get();
			Dog dog2 = op2.get();
			for (Matches matches: mRepo.findAll()) {
				if (matches.getThisDog().equals(dog) && matches.getThatDog().equals(dog2)) {
					return null;
				}
				if(matches.getThisDog().equals(dog2) && matches.getThatDog().equals(dog)) {
					return null;
				}
			}
			match.setThatDog(op2.get());
			match.setThisDog(op.get());
			mRepo.saveAndFlush(match);
			dog.addMatch(match);
			dog2.addMatch(match);
			dogRepo.saveAndFlush(dog);
			dogRepo.saveAndFlush(dog2);
			return dog;
		}
		return null;
	}

	@Override
	public Dog deleteMatch(Integer thisDog, Integer thatDog) {
		Optional<Dog> op = dogRepo.findById(thisDog);
		Optional<Dog> op2 = dogRepo.findById(thatDog);
		Matches match =  mRepo.findByThisDog_idAndThatDog_id(thisDog, thatDog);
		if(op.isPresent() && op2.isPresent()) {
			match.setThatDog(null);
			match.setThisDog(null);
			Dog dog = op.get();
			Dog dog2 = op2.get();
			dog.removeMatch(match);
			dog2.removeMatch(match);
			mRepo.delete(match);
			dogRepo.saveAndFlush(dog);
			dogRepo.saveAndFlush(dog2);
			return dog;
		}
		return null;
	}

	@Override
	public Set<Matches> getAllMatches(Integer dogId) {
		return mRepo.findByThisDog_idOrThatDog_id(dogId, dogId);
	}

}
