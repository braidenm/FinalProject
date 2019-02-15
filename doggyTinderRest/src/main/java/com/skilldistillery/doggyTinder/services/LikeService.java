package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Like;

public interface LikeService {
	
	public Dog addlike(Integer thisDog, Integer thatDog);
	public List<Like> getAllLikes(Integer thisDog);
	public List<Like> findByThatDogId(Integer thatDog);
}
