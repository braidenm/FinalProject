package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Preferences;

public interface PreferencesRepo extends JpaRepository<Preferences, Integer> {

	Preferences findPreferencesByDog_Id(Integer dId);
}
