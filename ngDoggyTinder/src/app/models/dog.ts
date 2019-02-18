import { User } from './user';


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
    this.active;
    this.sex = sex;
  }
}
