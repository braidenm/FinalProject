import { Address } from './address';
import { Dog } from './dog';
export class User {
  id: number;
  username: string;
  password: string;
  role: string;
  email: string;
  active: boolean;
  banned: boolean;
  firstName: string;
  lastName: string;
  gender: string;
  address: Address;
  age: number;
  dogs: Dog[];
  url: string;

  constructor(
    id?: number,
    username?: string,
    password?: string,
    role?: string,
    email?: string,
    active?: boolean,
    banned?: boolean,
    firstName?: string,
    lastName?: string,
    gender?: string,
    address?: Address,
    age?: number,
    dogs?: Dog[],
    url?: string
  ) {
    this.id = id,
    this.username = username,
    this.password = password,
    this.role = role,
    this.email = email,
    this.active = active,
    this.banned = banned,
    this.firstName = firstName,
    this.lastName = lastName,
    this.gender = gender,
    this.address = address;
    this.age = age;
    this.dogs = dogs;
    this.url = url;
  }
}
