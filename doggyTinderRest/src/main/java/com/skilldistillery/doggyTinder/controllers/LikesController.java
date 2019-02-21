package com.skilldistillery.doggyTinder.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;
import com.skilldistillery.doggyTinder.services.LikeService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class LikesController {
	
	@Autowired
	private LikeService lServ;
	
	@GetMapping("dogs/likes/{thisId}/{thatId}")
	public Dog addLike(HttpServletResponse res, @PathVariable Integer thisId, @PathVariable Integer thatId) {

		try {
			res.setStatus(201);
			return lServ.addlike(thisId, thatId);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;

		}

	}
	@GetMapping("dogs/likes/thisDog/{id1}")
	public List<Likes> getAllLikesByThisDog(HttpServletResponse res, @PathVariable Integer id1) {
		
		try {
			res.setStatus(201);
			return lServ.getAllLikesByThisDog(id1);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
			
		}
	}
	
	@GetMapping("dogs/likes/thatDog/{id1}")
	public List<Likes> getAllLikesByThatDog(HttpServletResponse res, @PathVariable Integer id1) {
		
		try {
			res.setStatus(201);
			return lServ.getAllLikesByThatDogId(id1);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
			
		}
	}
	
	@GetMapping("dogs/likes")
	public List<Likes> getAllLikes(HttpServletResponse res) {
		try {
			res.setStatus(201);
			return lServ.getAllLikes();
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	

}
