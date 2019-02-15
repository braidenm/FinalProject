package com.skilldistillery.doggyTinder.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.doggyTinder.entities.Address;

class AddressTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	


	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("DoggyTinder");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
	}

	@Test
	void test_address_connection() {
		
		Address a = em.find(Address.class, 1);
		
		assertEquals("7400 E Orchard Rd #1450n", a.getStreet());
		assertEquals("Greenwood Village", a.getCity());
		assertEquals("Colorado", a.getState());
		
	}

}
