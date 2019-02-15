package com.skilldistillery.doggyTinder.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Dislike {
	
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((thatDog == null) ? 0 : thatDog.hashCode());
		result = prime * result + ((thisDog == null) ? 0 : thisDog.hashCode());
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
		Dislike other = (Dislike) obj;
		if (thatDog == null) {
			if (other.thatDog != null)
				return false;
		} else if (!thatDog.equals(other.thatDog))
			return false;
		if (thisDog == null) {
			if (other.thisDog != null)
				return false;
		} else if (!thisDog.equals(other.thisDog))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Dislike [thisDog=" + thisDog + ", thatDog=" + thatDog + "]";
	}

	public Dislike(Dog thisDog, Dog thatDog) {
		super();
		this.thisDog = thisDog;
		this.thatDog = thatDog;
	}

	public Dislike() {
		super();
	}
	
	
}
