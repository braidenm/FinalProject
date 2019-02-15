package com.skilldistillery.doggyTinder.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.skilldistillery.doggyTinder.entities.User;
import com.skilldistillery.doggyTinder.repositories.UserRepo;

public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Autowired
	private UserRepo uRepo;
	
	@Override
	public User register(User user) {
		user.setPassword(pwEncoder.encode(user.getPassword()));
		user.setActive(true);user.setRole("standard");
		uRepo.saveAndFlush(user);
		return user;
	}

}
