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

import com.skilldistillery.doggyTinder.entities.Dislike;
import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;
import com.skilldistillery.doggyTinder.services.DislikeService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class DislikeController {

	@Autowired
	private DislikeService dServ;

	@PostMapping("dogs/dislikes/{id1}/{id2}")
	public Dog addDislike(HttpServletResponse res, @PathVariable Integer id1, @PathVariable Integer id2) {

		try {
			res.setStatus(201);
			return dServ.addDislike(id1, id2);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;

		}

	}
	@GetMapping("dogs/dislikes/thisDog/{id1}")
	public List<Dislike> getAllDislikesByThisDog(HttpServletResponse res, @PathVariable Integer id1) {
		
		try {
			res.setStatus(201);
			return dServ.getAllDislikesByThisDog(id1);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
			
		}
	}
	
	@GetMapping("dogs/dislikes/thatDog/{id1}")
	public List<Dislike> getAllDislikesByThatDog(HttpServletResponse res, @PathVariable Integer id1) {
		
		try {
			res.setStatus(201);
			return dServ.getAllDislikesByThatDog(id1);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
			
		}
	}
	
	@GetMapping("dogs/dislikes")
	public List<Dislike> getAllDislikes(HttpServletResponse res) {
		try {
			res.setStatus(201);
			return dServ.getAllDislikes();
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
}
