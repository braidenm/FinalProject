package com.skilldistillery.doggyTinder.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.doggyTinder.services.UserService;

@Controller
public class DogController {
	
	@Autowired
	private UserService uServ;

}
