package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.User;
import com.skilldistillery.doggyTinder.repositories.UserRepo;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserRepo uRepo;

	@Override
	public List<User> index() {
		return uRepo.findAll();
	}

	@Override
	public User showUser(Integer id) {
		Optional<User> op = uRepo.findById(id);
		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	@Override
	public void deleteUser(Integer id) {
		User u = uRepo.findById(id).get();
		DogService dserve = new DogServiceImpl();
		for (Dog dog : u.getDogs()) {
			dserve.delete(dog.getId());
			
		}
		uRepo.delete(u);
		
	}

	@Override
	public User updateUser(User user) {
		Optional<User> op = uRepo.findById(user.getId());
		try {
			if (op.isPresent()) {
				User managed = op.get();
				System.out.println("*******************************");
				System.out.println(user);
				System.out.println(managed);
				managed.setUsername(user.getUsername());
				managed.setPassword(user.getPassword());
				managed.setEmail(user.getEmail());
				managed.setFirstName(user.getFirstName());
				managed.setLastName(user.getLastName());
				managed.setGender(user.getGender());
				managed.setAge(user.getAge());
				managed.setUrl(user.getUrl());
				managed.setAddress(user.getAddress());
				managed.setEnabled(user.getEnabled());
				managed.setActive(user.getActive());
				uRepo.saveAndFlush(managed);
				return managed;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	@Override
	public User findByUserName(String userName) {
		
		return uRepo.findByUsername(userName);
	}


}
