package com.skilldistillery.doggyTinder.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Matches {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="dog1_id")
	private Dog thisDog;
	
	@ManyToOne
	@JoinColumn(name="dog2_id")
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
		Matches other = (Matches) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Match [thisDog=" + thisDog + ", thatDog=" + thatDog + "]";
	}

	public Matches(int id, Dog thisDog, Dog thatDog) {
		this.id = id;
		this.thisDog = thisDog;
		this.thatDog = thatDog;
	}

	public Matches() {
		super();
	}


	
	
}
