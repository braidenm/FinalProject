package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Message;

public interface MessageService {

	public Message addMessage(String message, Integer sender, Integer receiver);
	public List<Message> findByReceiverIdAndSenderIdOrderByDateAsc(int rid, int sid);
	public List<Message> findByReceiverId(int rid);
	public List<Message> findBySenderId(int sid);
		
}
