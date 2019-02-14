package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Address;

public interface addressRepo extends JpaRepository<Address, Integer> {

}
