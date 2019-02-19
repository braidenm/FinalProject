package com.skilldistillery.doggyTinder.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.doggyTinder.entities.Message;
import com.skilldistillery.doggyTinder.services.MessageService;

@CrossOrigin({ "*", "http://localhost:4205" })
@RestController
@RequestMapping("api")
public class MessageController {
	
	@Autowired
	MessageService mServ;
	
	@PostMapping("messages/{text}/{dogIdS}/{dogIdR}")
	public Message add(HttpServletResponse res, @PathVariable String text, 
						@PathVariable Integer dogIdS, @PathVariable Integer dogIdR) {

		try {
			res.setStatus(201);
			return mServ.addMessage(text, dogIdS, dogIdR);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("messages/{dogIdS}/{dogIdR}")
	public List<Message> getConversation(HttpServletResponse res, @PathVariable Integer dogIdS, @PathVariable Integer dogIdR) {
		
		try {
			res.setStatus(201);
			List<Message> messages = mServ.findByReceiverIdAndSenderIdOrderByDateAsc(dogIdS, dogIdR);
			messages.addAll(mServ.findByReceiverIdAndSenderIdOrderByDateAsc(dogIdR, dogIdS));
			return messages;
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	@GetMapping("messages/receiver/{dogIdR}")
	public List<Message> findByReceiver(HttpServletResponse res, @PathVariable Integer dogIdR) {
		
		try {
			res.setStatus(201);
			return mServ.findByReceiverId(dogIdR);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	@GetMapping("messages/sender/{dogIdS}")
	public List<Message> findBySender(HttpServletResponse res, @PathVariable Integer dogIdS) {
		
		try {
			res.setStatus(201);
			return mServ.findBySenderId(dogIdS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}


}
