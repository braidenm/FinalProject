package com.skilldistillery.doggyTinder.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Likes {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="this_dog")
	private Dog thisDog;
	
	@ManyToOne
	@JoinColumn(name="that_dog")
	private Dog thatDog;

	public Dog getThisDog() {
		return thisDog;
	}

	public void setThisDog(Dog thisDog) {
		this.thisDog = thisDog;
	}

	public Dog getThatDog() {
		return thatDog;
	}

	public void setThatDog(Dog thatDog) {
		this.thatDog = thatDog;
	}

	

	public Likes(int id, Dog thisDog, Dog thatDog) {
		super();
		this.id = id;
		this.thisDog = thisDog;
		this.thatDog = thatDog;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Likes other = (Likes) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Like [id=" + id + ", thisDog=" + thisDog + ", thatDog=" + thatDog + "]";
	}

	public Likes() {
		super();
	}
	
	
}
