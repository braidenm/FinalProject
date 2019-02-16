package com.skilldistillery.doggyTinder.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fasterxml.jackson.databind.deser.DataFormatReaders.Match;
import com.skilldistillery.doggyTinder.entities.Matches;

public interface MatchRepo extends JpaRepository<Matches, Integer> {

	Set<Matches> findByThisDog_idOrThatDog_id(Integer id, Integer id2);
	Matches findByThisDog_idAndThatDog_id(Integer id, Integer id2);
}
