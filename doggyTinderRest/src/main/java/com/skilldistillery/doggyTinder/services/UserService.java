package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Address;
import com.skilldistillery.doggyTinder.entities.User;

public interface UserService {
	
	
	public List <User> index();
	public User showUser(Integer id);
	public void deleteUser(Integer id);
	public User updateUser(User user);
	public User createUser(User user);
	public Address updateAddr(Address address);
	public Address createAddr(Address address);
	public Address deleteAddr(Address address);
	public Address showAddr(Address address);

}
