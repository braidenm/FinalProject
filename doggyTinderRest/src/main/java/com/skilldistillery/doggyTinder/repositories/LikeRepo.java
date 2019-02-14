package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Like;

public interface LikeRepo extends JpaRepository<Like, Integer> {
	
	

}
