package com.skilldistillery.doggyTinder.entities;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.doggyTinder.entities.Dog;

class DogTest {
	
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
	void test_dog_connection() {
		
		Dog d = em.find(Dog.class, 1);
		
		assertEquals("Spot", d.getName());
		assertEquals("Mutt", d.getBreed());
		assertNotNull(d.getLikes());
		assertNotNull(d.getDislikes());
		assertNotNull(d.getPreferences());
		assertNotNull(d.getMatches());
		assertNotNull(d.getMessages());
		assertNotNull(d.getPhotos());
		
	}

}
