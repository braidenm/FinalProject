package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Message;

public class MessageServiceImpl implements MessageService {

	@Override
	public Dog addMessage(String message, Integer sender, Integer receiver) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Message> findByReceiverIdAndSenderIdOrderByDateAsc(int rid, int sid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Message> findByReceiverId(int rid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Message> findBySenderId(int sid) {
		// TODO Auto-generated method stub
		return null;
	}

}
