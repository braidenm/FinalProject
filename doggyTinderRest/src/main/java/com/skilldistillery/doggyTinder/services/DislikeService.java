package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dislike;
import com.skilldistillery.doggyTinder.entities.Dog;

public interface DislikeService {
	public Dog addDislike(Integer thisDog, Integer thatDog);
	public List<Dislike> getAllDislikes(Integer dogId);

}
