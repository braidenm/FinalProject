package com.skilldistillery.doggyTinder.services;

import java.util.Set;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Matches;

public interface MatchService {
	
	public Dog addMatch(Integer thisDog, Integer thatDog);
	public Dog deleteMatch(Integer thisDog, Integer thatDog);
	public Set<Matches> getAllMatches(Integer dogId);

}
