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
	public Dog addMessage(String text, Integer sender, Integer receiver) {
		Optional<Dog> op = dRepo.findById(sender);
		Optional<Dog> op2 = dRepo.findById(receiver);
		Message message = new Message();
		if(op.isPresent() && op2.isPresent()) {
			Dog senderDog = op.get();
			Dog receiveDog = op2.get();
			message.setThisDog(senderDog);
			message.setThatDog(receiveDog);
			message.setText(text);
			mRepo.saveAndFlush(message);
			senderDog.addMessage(message);
			dRepo.saveAndFlush(senderDog);
			return senderDog;
		}
		
		return null;
	}

	@Override
	public List<Message> findByReceiverIdAndSenderIdOrderByDateAsc(int rid, int sid) {
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

}
