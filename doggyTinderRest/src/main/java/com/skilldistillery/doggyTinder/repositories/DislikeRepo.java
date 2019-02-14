package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Dislike;
import com.skilldistillery.doggyTinder.entities.Dog;

public interface DislikeRepo extends JpaRepository<Dislike, Dog> {

}
