package com.skilldistillery.doggyTinder.services;

import java.util.List;

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Likes;
import com.skilldistillery.doggyTinder.entities.Photo;
import com.skilldistillery.doggyTinder.entities.Preferences;

public interface DogService {
	
	public List <Dog> index();
	public Dog show(Integer id);
	public void delete(Integer id);
	public Dog create(Dog dog, int userId);
	public Dog update(Dog dog);
	public List<Dog> getAllDogsByUserId(Integer id);
	public List<Dog> findByNameLike(String name);
	public List<Dog> findByBreedLike(String breed);
	public Dog updatePref(Preferences pref, Integer id);
	public Dog addPhoto(String imageUrl, Integer dogId);
	public Dog deletePhoto(Integer dogId, Integer photoId);
	public Preferences getPreferencesByDogId(Integer id);
	List<Photo> getPhotosByDogId(Integer dogId);
	
}
