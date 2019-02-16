package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;

public interface LikeService {
	
	public Dog addlike(Integer thisDog, Integer thatDog);
	public List<Likes> getAllLikes();
	List<Likes> getAllLikesByThisDog(Integer thisDog);
	List<Likes> getAllLikesByThatDogId(Integer thatDog);
}
