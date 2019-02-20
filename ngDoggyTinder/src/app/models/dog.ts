import { Message } from './message';
import { Likes } from './likes';
import { Preferences } from './preferences';
import { User } from './user';
import { Photo } from './photo';
import { DisLike } from './dis-like';


export class Dog {
  id: number;
  user: User;
  name: string;
  breed: string;
  weight: number;
  energy: number;
  age: number;
  about: string;
  active: boolean;
  sex: string;
  photos: Photo[];
  Preferences: Preferences;
  likes: Likes[];
  dislikes: DisLike[];
  messages: Message[];


  constructor(
    id?: number,
    user?: User,
    name?: string,
    breed?: string,
    weight?: number,
    energy?: number,
    age?: number,
    about?: string,
    active?: boolean,
    sex?: string,
    likes?: Likes[],
    dislikes?: DisLike[],
    messages?: Message[],
    photos?: Photo[]
  ) {
    this.id = id;
    this.user = user;
    this.name = name;
    this.breed = breed;
    this.weight = weight;
    this.energy = energy;
    this.age = age;
    this.about = about;
    this.active = active;
    this.sex = sex;
    this.likes = likes;
    this.dislikes = dislikes;
    this.messages = messages;
    this.photos = photos;
  }
}
