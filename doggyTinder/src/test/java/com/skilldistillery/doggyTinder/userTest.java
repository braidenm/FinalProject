package com.skilldistillery.doggyTinder;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.doggyTinder.entities.User;

class userTest {
	
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
	void test_connection() {
		
		User u = em.find(User.class, 1);
		
		assertEquals("", "username");
		assertEquals("", "email");
		assertEquals("", "address");
		assertEquals("", "dogs");
		
		
	}

}
