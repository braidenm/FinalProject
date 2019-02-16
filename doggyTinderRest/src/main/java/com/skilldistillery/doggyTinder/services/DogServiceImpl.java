package com.skilldistillery.doggyTinder.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.doggyTinder.entities.Dislike;
import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;
import com.skilldistillery.doggyTinder.entities.Matches;
import com.skilldistillery.doggyTinder.entities.Message;
import com.skilldistillery.doggyTinder.entities.Photo;
import com.skilldistillery.doggyTinder.entities.Preferences;
import com.skilldistillery.doggyTinder.entities.User;
import com.skilldistillery.doggyTinder.repositories.DislikeRepo;
import com.skilldistillery.doggyTinder.repositories.DogRepo;
import com.skilldistillery.doggyTinder.repositories.LikeRepo;
import com.skilldistillery.doggyTinder.repositories.MatchRepo;
import com.skilldistillery.doggyTinder.repositories.MessageRepo;
import com.skilldistillery.doggyTinder.repositories.PhotoRepo;
import com.skilldistillery.doggyTinder.repositories.PreferencesRepo;
import com.skilldistillery.doggyTinder.repositories.UserRepo;

@Service
public class DogServiceImpl implements DogService {

	@Autowired
	private DogRepo dRepo;
	@Autowired
	private UserRepo uRepo;
	@Autowired
	private PhotoRepo pRepo;
	@Autowired
	private PreferencesRepo prefRepo;
	@Autowired
	private MessageRepo messRepo;
	@Autowired
	private LikeRepo likeRepo;
	@Autowired
	private DislikeRepo disRepo;
	@Autowired
	private MatchRepo matchRepo;

	@Override
	public List<Dog> index() {
		return dRepo.findAll();
	}

	@Override
	public Dog show(Integer id) {

		Optional<Dog> op = dRepo.findById(id);
		if (op.isPresent()) {
			return op.get();
		}
		return null;
	}

	@Override
	public void delete(Integer id) {
		Optional<Dog> op = dRepo.findById(id);
		if (op.isPresent()) {
			Dog dog = op.get();
			
			List<Photo> photos = dog.getPhotos();
			for (Photo photo : photos) {
				photo.setDog(null);
				pRepo.deleteById(photo.getId());
			}
			dog.setPhotos(null);
			
			Preferences pref = dog.getPreferences();
			dog.setPreferences(null);
			pref.setDog(null);
			prefRepo.deleteById(pref.getId());
			
			List<Message> messages = dog.getMessages();
			for (Message message : messages) {
				message.setThatDog(null);
				message.setThisDog(null);
				messRepo.deleteById(message.getId());
			}
			dog.setMessages(null);
			
			List<Likes> likes = dog.getLikes();
			for (Likes likes2 : likes) {
				likes2.setThatDog(null);
				likes2.setThisDog(null);
				likeRepo.deleteById(likes2.getId());
			}
			dog.setLikes(null);
			
			List<Dislike> dislikes = dog.getDislikes();
			for (Dislike dislike : dislikes) {
				dislike.setThatDog(null);
				dislike.setThisDog(null);
				disRepo.deleteById(dislike.getId());;
			}
			dog.setDislikes(null);
			
			List<Matches> matches = dog.getMatches();
			for (Matches matches2 : matches) {
				matches2.setThatDog(null);
				matches2.setThisDog(null);
				matchRepo.deleteById(matches2.getId());
			}
			dog.setMatches(null);
			
			dRepo.saveAndFlush(dog);
			dRepo.deleteById(id);
		}
	}

	@Override
	public Dog create(Dog dog, int userId) {
		dog.setActive(true);
		Optional<User> op = uRepo.findById(userId);
		try {
			if (op.isPresent()) {
				dog.setUser(op.get());
				dRepo.saveAndFlush(dog);
				Preferences pref = new Preferences();
				pref.setDog(dog);
				prefRepo.saveAndFlush(pref);
				dog.setPreferences(pref);
				dRepo.saveAndFlush(dog);
				return dog;
			}
			System.out.println("invalid user");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public Dog update(Dog dog) {
		Optional<Dog> op = dRepo.findById(dog.getId());
		try {
			if (op.isPresent()) {
				Dog managed = op.get();
				managed.setAbout(dog.getAbout());
				managed.setAge(dog.getAge());
				managed.setName(dog.getName());
				managed.setBreed(dog.getBreed());
				managed.setWeight(dog.getWeight());
				managed.setEnergy(dog.getEnergy());
				managed.setAbout(dog.getAbout());
				dRepo.saveAndFlush(managed);
				return managed;
			}
			System.out.println("invalid dog");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<Dog> getAllDogsByUserId(Integer id) {
		Optional<User> uOp = uRepo.findById(id);
		try {
			if (uOp.isPresent()) {
				User user = uOp.get();
				return user.getDogs();
			}
			System.out.println("invalid user. Error at DogServiceImpl.getAllDogsByUserId");
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<Dog> findByNameLike(String name) {
		return dRepo.findByNameLike("%" + name + "%");
	}

	@Override
	public List<Dog> findByBreedLike(String breed) {
		return dRepo.findByBreedLike("%" + breed + "%");
	}

	@Override
	public Dog updatePref(Preferences pref, Integer id) {
		Optional<Dog> op = dRepo.findById(id);
		if (op.isPresent()) {
			Dog dog = op.get();
			Preferences dogPref = dog.getPreferences();
			dogPref.setMaxAge(pref.getMaxAge());
			dogPref.setMinAge(pref.getMinAge());
			dogPref.setMaxEnergy(pref.getMaxEnergy());
			dogPref.setMinEnergy(pref.getMinEnergy());
			dogPref.setMaxWeight(pref.getMaxWeight());
			dogPref.setMinWeight(pref.getMinWeight());
			dog.setPreferences(dogPref);
			dRepo.saveAndFlush(dog);
			return dog;

		}
		return null;
	}

	@Override
	public Dog addPhoto(String urlString, Integer dogId) {
		Optional<Dog> op = dRepo.findById(dogId);
		if (op.isPresent()) {
			Dog dog = op.get();
			Photo photo = new Photo();
			photo.setDog(dog);
			photo.setUrl(urlString);
			dog.addPhoto(photo);
			dRepo.saveAndFlush(dog);
			return dog;
		}
		return null;
	}

	@Override
	public Dog deletePhoto(Integer dogId, Integer photoId) {
		Optional<Dog> op = dRepo.findById(dogId);
		Optional<Photo> op2 = pRepo.findById(photoId);
		if(op.isPresent() && op2.isPresent()) {
			Dog dog = op.get();
			Photo photo = op2.get();
			dog.removePhoto(photo);
			pRepo.deleteById(photoId);
			dRepo.saveAndFlush(dog); 
			return dog;
		}
		return null;
	}

}
