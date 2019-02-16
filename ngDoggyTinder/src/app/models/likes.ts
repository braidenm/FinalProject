import { Dog } from "./dog";

export class Likes {
  id: number;
  thisDog: Dog;
  thatDog: Dog;

  constructor(id?: number, thisDog?: Dog, thatDog?: Dog) {
    this.id = id;
    this.thisDog = thisDog;
    this.thatDog = thatDog;
  }
}
