package com.skilldistillery.doggyTinder.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Dog {
	//Feilds
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	private String name;
	private String breed;
	private Integer weight;
	private Integer energy;
	private Integer age;
	private String about;
	@OneToOne(mappedBy="dog")
	private Preferences preferences;
	@OneToMany(mappedBy="thisDog")
	private List<Like> likes;
	@OneToMany(mappedBy="thisDog")
	private List<Message> messages;
	@OneToMany(mappedBy="dog")
	private List<Photo> photos;
	@OneToMany(mappedBy="thisDog")
	private List<Dislike> dislikes;
	@OneToMany(mappedBy="thisDog")
	private List<Match> matches;
	
	//Methods
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBreed() {
		return breed;
	}
	public void setBreed(String breed) {
		this.breed = breed;
	}
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	public Integer getEnergy() {
		return energy;
	}
	public void setEnergy(Integer energy) {
		this.energy = energy;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public Preferences getPreferences() {
		return preferences;
	}
	public void setPreferences(Preferences preferences) {
		this.preferences = preferences;
	}
	public List<Like> getLikes() {
		return likes;
	}
	public void setLikes(List<Like> likes) {
		this.likes = likes;
	}
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public List<Photo> getPhotos() {
		return photos;
	}
	public void setPhotos(List<Photo> photos) {
		this.photos = photos;
	}
	public List<Dislike> getDislikes() {
		return dislikes;
	}
	public void setDislikes(List<Dislike> dislikes) {
		this.dislikes = dislikes;
	}
	public List<Match> getMatches() {
		return matches;
	}
	public void setMatches(List<Match> matches) {
		this.matches = matches;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((about == null) ? 0 : about.hashCode());
		result = prime * result + ((age == null) ? 0 : age.hashCode());
		result = prime * result + ((breed == null) ? 0 : breed.hashCode());
		result = prime * result + ((dislikes == null) ? 0 : dislikes.hashCode());
		result = prime * result + ((energy == null) ? 0 : energy.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((likes == null) ? 0 : likes.hashCode());
		result = prime * result + ((matches == null) ? 0 : matches.hashCode());
		result = prime * result + ((messages == null) ? 0 : messages.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((photos == null) ? 0 : photos.hashCode());
		result = prime * result + ((preferences == null) ? 0 : preferences.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		result = prime * result + ((weight == null) ? 0 : weight.hashCode());
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
		Dog other = (Dog) obj;
		if (about == null) {
			if (other.about != null)
				return false;
		} else if (!about.equals(other.about))
			return false;
		if (age == null) {
			if (other.age != null)
				return false;
		} else if (!age.equals(other.age))
			return false;
		if (breed == null) {
			if (other.breed != null)
				return false;
		} else if (!breed.equals(other.breed))
			return false;
		if (dislikes == null) {
			if (other.dislikes != null)
				return false;
		} else if (!dislikes.equals(other.dislikes))
			return false;
		if (energy == null) {
			if (other.energy != null)
				return false;
		} else if (!energy.equals(other.energy))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (likes == null) {
			if (other.likes != null)
				return false;
		} else if (!likes.equals(other.likes))
			return false;
		if (matches == null) {
			if (other.matches != null)
				return false;
		} else if (!matches.equals(other.matches))
			return false;
		if (messages == null) {
			if (other.messages != null)
				return false;
		} else if (!messages.equals(other.messages))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (photos == null) {
			if (other.photos != null)
				return false;
		} else if (!photos.equals(other.photos))
			return false;
		if (preferences == null) {
			if (other.preferences != null)
				return false;
		} else if (!preferences.equals(other.preferences))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		if (weight == null) {
			if (other.weight != null)
				return false;
		} else if (!weight.equals(other.weight))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Dog [id=" + id + ", user=" + user + ", name=" + name + ", breed=" + breed + ", weight=" + weight
				+ ", energy=" + energy + ", age=" + age + ", about=" + about + "]";
	}
	public Dog(Integer id, User user, String name, String breed, Integer weight, Integer energy, Integer age,
			String about, Preferences preferences, List<Like> likes, List<Message> messages, List<Photo> photos,
			List<Dislike> dislikes, List<Match> matches) {
		super();
		this.id = id;
		this.user = user;
		this.name = name;
		this.breed = breed;
		this.weight = weight;
		this.energy = energy;
		this.age = age;
		this.about = about;
		this.preferences = preferences;
		this.likes = likes;
		this.messages = messages;
		this.photos = photos;
		this.dislikes = dislikes;
		this.matches = matches;
	}
	public Dog() {
		super();
	}
	
	public List<Like> addTodo( Like like){
		if(likes == null) {
			likes = new ArrayList<Like>();
		}
		if(!likes.contains(like) && like != null) {
			likes.add(like);
		}
		
		return likes;
	}
	
	public boolean removeTodo(Like like) {
		if(!likes.isEmpty()) {
			if(likes.contains(like)) {
				likes.remove(like);
				return true;
			}
			
		}
		return false;
	}
	
	public List<Message> addTodo( Message message){
		if(messages == null) {
			messages = new ArrayList<Message>();
		}
		if(!messages.contains(message) && message != null) {
			messages.add(message);
		}
		
		return messages;
	}
	
	public boolean removeTodo(Message message) {
		if(!messages.isEmpty()) {
			if(messages.contains(message)) {
				messages.remove(message);
				return true;
			}
			
		}
		return false;
	}
	
	public List<Dislike> addTodo( Dislike dislike){
		if(dislikes == null) {
			dislikes = new ArrayList<Dislike>();
		}
		if(!dislikes.contains(dislike) && dislike != null) {
			dislikes.add(dislike);
		}
		
		return dislikes;
	}
	
	public boolean removeTodo(Dislike dislike) {
		if(!dislikes.isEmpty()) {
			if(dislikes.contains(dislike)) {
				dislikes.remove(dislike);
				return true;
			}
			
		}
		return false;
	}
	
	public List<Photo> addTodo( Photo photo){
		if(photos == null) {
			photos = new ArrayList<Photo>();
		}
		if(!photos.contains(photo) && photo != null) {
			photos.add(photo);
		}
		
		return photos;
	}
	
	public boolean removeTodo(Photo photo) {
		if(!photos.isEmpty()) {
			if(photos.contains(photo)) {
				photos.remove(photo);
				return true;
			}
			
		}
		return false;
	}
	
	public List<Match> addTodo( Match match){
		if(matches == null) {
			matches = new ArrayList<Match>();
		}
		if(!matches.contains(match) && match != null) {
			matches.add(match);
		}
		
		return matches;
	}
	
	public boolean removeTodo(Match todo) {
		if(!matches.isEmpty()) {
			if(matches.contains(todo)) {
				matches.remove(todo);
				return true;
			}
			
		}
		return false;
	}
	
}
