package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Photo;

public interface PhotoRepo extends JpaRepository<Photo, Integer> {

}
