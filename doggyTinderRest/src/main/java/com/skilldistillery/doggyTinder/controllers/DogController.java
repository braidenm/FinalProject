package com.skilldistillery.doggyTinder.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Photo;
import com.skilldistillery.doggyTinder.entities.Preferences;
import com.skilldistillery.doggyTinder.services.DogService;
import com.skilldistillery.doggyTinder.services.UserService;

@CrossOrigin({ "*", "http://localhost:4205" })
@RestController
@RequestMapping("api")
public class DogController {

	@Autowired
	private UserService uServ;
	@Autowired
	private DogService dServ;

	@GetMapping("dogs")
	public List<Dog> index(HttpServletResponse res) {

		try {
			res.setStatus(201);
			List<Dog> result = dServ.index();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("dogs/{id}")
	public Dog show(HttpServletResponse res, @PathVariable Integer id) {
		try {
			res.setStatus(201);
			return dServ.show(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("dogs/{id}/pref")
	public Preferences showPref(HttpServletResponse res, @PathVariable Integer id) {
		try {
			res.setStatus(201);
			
			return dServ.getPreferencesByDogId(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

	@DeleteMapping("dogs/{id}")
	public void delete(HttpServletResponse res, @PathVariable Integer id) {

		try {
			res.setStatus(204);
			dServ.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
	}

	@PostMapping("dogs/{id}")
	public Dog create(HttpServletResponse res, @PathVariable Integer id, @RequestBody Dog dog) {

		try {
			res.setStatus(201);
			return dServ.create(dog, id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}

	@PutMapping("dogs")
	public Dog update(HttpServletResponse res, @RequestBody Dog dog) {

		try {
			res.setStatus(204);
			return dServ.update(dog);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("dogs/users/{id}")
	public List <Dog> getAllDogsByUser(HttpServletResponse res, @PathVariable Integer id) {
		
		try {
			res.setStatus(201);
			return dServ.getAllDogsByUserId(id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	
	@GetMapping("dogs/name/{name}")
	public List <Dog> findByNameLike(HttpServletResponse res, @PathVariable String name) {
		
		try {
			res.setStatus(201);
			return dServ.findByNameLike(name);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	@GetMapping("dogs/breed/{breed}")
	public List <Dog> findByBreedLike(HttpServletResponse res, @PathVariable String breed) {
		
		try {
			res.setStatus(201);
			return dServ.findByBreedLike(breed);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@PutMapping("dogs/{id}/pref")
	public Dog updatePreferences(HttpServletResponse res, @PathVariable Integer id, @RequestBody Preferences pref) {
		
		try {
			res.setStatus(201);
			return dServ.updatePref(pref, id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	@PostMapping("dogs/{id}/photo")
	public Dog addPhoto(HttpServletResponse res, @PathVariable Integer id, @RequestBody Photo photo) {
		
		try {
			res.setStatus(201);
			return dServ.addPhoto(photo.getUrl(), id);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	@DeleteMapping("dogs/{id}/photo/{pid}")
	public Dog deletePhoto(HttpServletResponse res, @PathVariable Integer id, @PathVariable Integer pid) {
		
		try {
			res.setStatus(201);
			return dServ.deletePhoto(id, pid);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("dogs/{id}/photo")
	public List<Photo> getPhotos(HttpServletResponse res, @PathVariable Integer id) {
		try {
			res.setStatus(201);
			return dServ.getPhotosByDogId(id);
		} catch (Exception e ) {
			e.printStackTrace();
			res.setStatus(404);
			return null;
		}
	}
	
	@GetMapping("dogs/{id}/filtered")
	public List<Dog> getFilteredDogs(HttpServletResponse res, @PathVariable Integer id) {
		try {
			res.setStatus(201);
			return dServ.getFilteredDogs(id);
		} catch (Exception e ) {
			e.printStackTrace();
			return null;
		}
	}
	
	

}
