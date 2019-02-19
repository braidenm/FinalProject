package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Message;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.MessageRepo;

@Service
public class MessageServiceImpl implements MessageService {

	
	@Autowired
	private MessageRepo mRepo;
	@Autowired
	private DogRepo dRepo;
	
	
	@Override
	public Message addMessage(String text, Integer sender, Integer receiver) {
		Optional<Dog> op = dRepo.findById(sender);
		Optional<Dog> op2 = dRepo.findById(receiver);
		Message message = new Message();
		if(op.isPresent() && op2.isPresent()) {
			Dog senderDog = op.get();
			Dog receiveDog = op2.get();
			message.setThisDog(senderDog);
			message.setRead(false);
			message.setThatDog(receiveDog);
			message.setText(text);
			mRepo.saveAndFlush(message);
			senderDog.addMessage(message);
			dRepo.saveAndFlush(senderDog);
			return message;
		}
		
		return null;
	}

	@Override
	public List<Message> findByReceiverIdAndSenderIdOrderByDateAsc(int sid, int rid) {
		List<Message> messages = mRepo.findByThatDog_IdAndThisDog_IdOrderByDateAsc(rid, sid);
		return messages;
	}

	@Override
	public List<Message> findByReceiverId(int rid) {
			return mRepo.findByThatDog_Id(rid);
	}

	@Override
	public List<Message> findBySenderId(int sid) {
		return mRepo.findByThisDog_Id(sid);
	}

	@Override
	public Message updateMessage(Message message) {
		Optional<Message> op = mRepo.findById(message.getId());
		if(op.isPresent()) {
			Message managed = op.get();
			managed.setRead(message.isRead());
			mRepo.saveAndFlush(managed);
			return managed;
		}
		return null;
	}


}
