package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dislike;

public interface DislikeRepo extends JpaRepository<Dislike, Integer> {
	List<Dislike> findByThatDog_id(Integer thatDog);
	List<Dislike> findByThisDog_id(Integer thisDog);
}
