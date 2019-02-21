package com.skilldistillery.doggyTinder.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.doggyTinder.entities.Address;

public interface AddressRepo extends JpaRepository<Address, Integer> {

	
}
