package com.skilldistillery.doggyTinder.controllers;

import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Matches;
import com.skilldistillery.doggyTinder.services.MatchService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4205" })
public class MatchController {

	@Autowired
	private MatchService mServ;

	@PostMapping("matches/{thisId}/{thatId}")
	public Dog addMatch(HttpServletResponse res, @PathVariable Integer thisId,@PathVariable Integer thatId) {
		try {
			res.setStatus(201);
			return mServ.addMatch(thisId, thatId);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;

		}
	}

	@DeleteMapping("matches/{thisId}/{thatId}")
	public Dog deleteMatch(HttpServletResponse res, @PathVariable Integer thisId,@PathVariable Integer thatId) {
		try {
			res.setStatus(201);
			return mServ.deleteMatch(thisId, thatId);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

	@GetMapping("matches/{dogId}")
	public Set<Matches> getAllMatches(HttpServletResponse res, @PathVariable Integer dogId) {
		try {
			res.setStatus(201);
			return mServ.getAllMatches(dogId);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

}
