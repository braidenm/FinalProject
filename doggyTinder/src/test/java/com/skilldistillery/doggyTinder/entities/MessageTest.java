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

import com.skilldistillery.doggyTinder.entities.Dog;
import com.skilldistillery.doggyTinder.entities.Message;

class MessageTest {
	
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
	void test_message_connection() {
		
		Message m = em.find(Message.class, 1);
		Dog senderDog = em.find(Dog.class, m.getThisDog().getId());
		Dog receiverDog = em.find(Dog.class, m.getThatDog().getId());
		
		assertEquals("The Revolution", senderDog.getName());
		assertEquals("Little Dude", receiverDog.getName());
		assertEquals("Hi little dude!", m.getText());
//		assertEquals("2019-02-11 15:02:55", m.getDate().toString());
		
	}

}
