package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;

public interface LikeRepo extends JpaRepository<Likes, Dog> {
	
	List<Likes> findByThatDog_id(Integer thatDog);

}
