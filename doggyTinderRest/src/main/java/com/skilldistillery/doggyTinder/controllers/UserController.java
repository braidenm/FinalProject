package com.skilldistillery.doggyTinder.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.doggyTinder.entities.User;
import com.skilldistillery.doggyTinder.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class UserController {

	@Autowired
	private UserService uServ;

	@GetMapping("users/{id}")
	public User getById(HttpServletResponse res, @PathVariable Integer id) {
		try {
			res.setStatus(201);
			return uServ.showUser(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;

		}
	}
	@GetMapping("users/username")
	public User getByUsername(HttpServletResponse res, Principal principal) {
		try {
			res.setStatus(201);
			//TODO: hard coded for now
			return uServ.findByUserName("principal");
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

	@PutMapping("users")
	public User update(HttpServletResponse res, @RequestBody User user) {

		try {
			res.setStatus(201);
			return uServ.updateUser(user);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	

	@DeleteMapping("users/{id}")
	public void delete(HttpServletResponse res, Integer id) {
		try {
			res.setStatus(201);
			uServ.deleteUser(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
	}

	@GetMapping("users")
	public List<User> index(HttpServletResponse res) {
		try {
			res.setStatus(201);
			return uServ.index();
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

}
