package com.skilldistillery.doggyTinder.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class LikesTest {
	
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
	void test_like_connection() {
		
		Likes l = em.find(Likes.class, 1);
		System.out.println(l);
		assertTrue(1 == l.getThisDog().getId());
		assertTrue(2 == l.getThatDog().getId());
		
//		assertEquals("3", l.getThisDog().getId().toString());
//		assertEquals("2", l.getThatDog().getId().toString());
//		String thisDogName = l.getThisDog().getName();
//		String thatDogName = l.getThatDog().getName();
//		System.out.println(thisDogName + ", " + thatDogName);
//		assertEquals("Little Dude", thisDogName);
//		assertEquals("The Revolution", thatDogName);
		
	}

}
