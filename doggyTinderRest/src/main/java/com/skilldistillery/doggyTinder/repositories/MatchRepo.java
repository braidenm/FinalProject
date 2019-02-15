package com.skilldistillery.doggyTinder.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Match;


public interface MatchRepo extends JpaRepository<Match, Integer> {

	Set<Match> findByThisDog_idOrThatDog_id(Integer id, Integer id2);
}
