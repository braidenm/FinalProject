import { User } from './user';
import { Photo } from './photo';


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
    sex?: string
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
  }
}
