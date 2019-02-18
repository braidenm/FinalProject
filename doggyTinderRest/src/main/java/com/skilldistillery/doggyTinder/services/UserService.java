package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Address;
import com.skilldistillery.doggyTinder.entities.User;

public interface UserService {
	
	
	public List <User> index();
	public User showUser(Integer id);
	public void deleteUser(Integer id);
	public User updateUser(User user);
	public User findByUserName(String userName);
	
}
