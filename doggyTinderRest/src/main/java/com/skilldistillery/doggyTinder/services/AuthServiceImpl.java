package com.skilldistillery.doggyTinder.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.User;
import com.skilldistillery.doggyTinder.repositories.AddressRepo;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.UserRepo;
@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Autowired
	private UserRepo uRepo;
	@Autowired
	private AddressRepo aRepo;
	@Autowired
	private DogRepo dRepo;
	
	
	
	@Override
	public User register(User user) {
		user.setPassword(pwEncoder.encode(user.getPassword()));
		user.setActive(true);
		user.setRole("standard");
		user.setBanned(false);
		aRepo.saveAndFlush(user.getAddress());
		
		uRepo.saveAndFlush(user);
		return user;
	}

}
