package com.skilldistillery.doggyTinder.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Entity
public class Preferences {
	
	//Fields
	
	@OneToOne
	@JoinColumn(name="dog_id")
	private Dog	dog;
	@Column(name="min_weight")
	private Integer minWeight;
	@Column(name="max_weight")
	private Integer maxWeight;
	@Column(name="min_energy")
	private Integer minEnergy;
	@Column(name="max_energy")
	private Integer maxEnergy;
	@Column(name="min_age")
	private Integer minAge;
	@Column(name="max_age")
	private Integer maxAge;
	
	
	//Methods
	public Dog getDog() {
		return dog;
	}
	public void setDog(Dog dog) {
		this.dog = dog;
	}
	public Integer getMinWeight() {
		return minWeight;
	}
	public void setMinWeight(Integer minWeight) {
		this.minWeight = minWeight;
	}
	public Integer getMaxWeight() {
		return maxWeight;
	}
	public void setMaxWeight(Integer maxWeight) {
		this.maxWeight = maxWeight;
	}
	public Integer getMinEnergy() {
		return minEnergy;
	}
	public void setMinEnergy(Integer minEnergy) {
		this.minEnergy = minEnergy;
	}
	public Integer getMaxEnergy() {
		return maxEnergy;
	}
	public void setMaxEnergy(Integer maxEnergy) {
		this.maxEnergy = maxEnergy;
	}
	public Integer getMinAge() {
		return minAge;
	}
	public void setMinAge(Integer minAge) {
		this.minAge = minAge;
	}
	public Integer getMaxAge() {
		return maxAge;
	}
	public void setMaxAge(Integer maxAge) {
		this.maxAge = maxAge;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((dog == null) ? 0 : dog.hashCode());
		result = prime * result + ((maxAge == null) ? 0 : maxAge.hashCode());
		result = prime * result + ((maxEnergy == null) ? 0 : maxEnergy.hashCode());
		result = prime * result + ((maxWeight == null) ? 0 : maxWeight.hashCode());
		result = prime * result + ((minAge == null) ? 0 : minAge.hashCode());
		result = prime * result + ((minEnergy == null) ? 0 : minEnergy.hashCode());
		result = prime * result + ((minWeight == null) ? 0 : minWeight.hashCode());
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
		Preferences other = (Preferences) obj;
		if (dog == null) {
			if (other.dog != null)
				return false;
		} else if (!dog.equals(other.dog))
			return false;
		if (maxAge == null) {
			if (other.maxAge != null)
				return false;
		} else if (!maxAge.equals(other.maxAge))
			return false;
		if (maxEnergy == null) {
			if (other.maxEnergy != null)
				return false;
		} else if (!maxEnergy.equals(other.maxEnergy))
			return false;
		if (maxWeight == null) {
			if (other.maxWeight != null)
				return false;
		} else if (!maxWeight.equals(other.maxWeight))
			return false;
		if (minAge == null) {
			if (other.minAge != null)
				return false;
		} else if (!minAge.equals(other.minAge))
			return false;
		if (minEnergy == null) {
			if (other.minEnergy != null)
				return false;
		} else if (!minEnergy.equals(other.minEnergy))
			return false;
		if (minWeight == null) {
			if (other.minWeight != null)
				return false;
		} else if (!minWeight.equals(other.minWeight))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Preferences [dog=" + dog + ", minWeight=" + minWeight + ", maxWeight=" + maxWeight + ", minEnergy="
				+ minEnergy + ", maxEnergy=" + maxEnergy + ", minAge=" + minAge + ", maxAge=" + maxAge + "]";
	}
	public Preferences(Dog dog, Integer minWeight, Integer maxWeight, Integer minEnergy, Integer maxEnergy,
			Integer minAge, Integer maxAge) {
		super();
		this.dog = dog;
		this.minWeight = minWeight;
		this.maxWeight = maxWeight;
		this.minEnergy = minEnergy;
		this.maxEnergy = maxEnergy;
		this.minAge = minAge;
		this.maxAge = maxAge;
	}
	public Preferences() {
		super();
	}
	
	
	
}
