package com.skilldistillery.doggyTinder.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Message;

public interface MessageRepo extends JpaRepository<Message, Integer> {
	
	List<Message> findByReceiverIdAndSenderIdOrderByDateAsc(int rid, int sid);
	List<Message> findByReceiverId(int rid);
	List<Message> findBySenderId(int sid);

}
