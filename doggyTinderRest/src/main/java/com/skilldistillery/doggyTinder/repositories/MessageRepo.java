package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Message;

public interface MessageRepo extends JpaRepository<Message, Integer> {
	
	List<Message> findByThatDog_IdAndThisDog_IdOrderByDateAsc(int rid, int sid);
	List<Message> findByThatDog_Id(int rid);
	List<Message> findByThisDog_Id(int sid);

}
