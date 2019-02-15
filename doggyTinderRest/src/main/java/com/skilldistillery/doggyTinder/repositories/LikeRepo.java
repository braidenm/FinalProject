package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Like;

public interface LikeRepo extends JpaRepository<Like, Integer> {
	
	List<Like> findByThatDog_id(Integer thatDog);

}
