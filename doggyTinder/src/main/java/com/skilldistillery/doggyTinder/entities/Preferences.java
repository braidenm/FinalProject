package com.skilldistillery.doggyTinder.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Entity
public class Preferences {
	
	
	
	//Fields
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
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
	
	private String sex;
	
	//Methods
//	public Dog getDog() {
//		return dog;
//	}
//	public void setDog(Dog dog) {
//		this.dog = dog;
//	}
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
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Dog getDog() {
		return dog;
	}
	public void setDog(Dog dog) {
		this.dog = dog;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
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
		Preferences other = (Preferences) obj;
		if (id != other.id)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Preferences [id=" + id + ", dog=" + dog + ", minWeight=" + minWeight + ", maxWeight=" + maxWeight
				+ ", minEnergy=" + minEnergy + ", maxEnergy=" + maxEnergy + ", minAge=" + minAge + ", maxAge=" + maxAge
				+ "]";
	}
	public Preferences() {
	}
	public Preferences(int id, Dog dog, Integer minWeight, Integer maxWeight, Integer minEnergy, Integer maxEnergy,
			Integer minAge, Integer maxAge, String sex) {
		super();
		this.id = id;
		this.dog = dog;
		this.minWeight = minWeight;
		this.maxWeight = maxWeight;
		this.minEnergy = minEnergy;
		this.maxEnergy = maxEnergy;
		this.minAge = minAge;
		this.maxAge = maxAge;
		this.sex = sex;
	}

	
	
	
}
