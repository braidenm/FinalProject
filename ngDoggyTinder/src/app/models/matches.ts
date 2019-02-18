import { Dog } from './dog';
import { Photo } from './photo';

export class Matches {

  id: number;
  thisDog: Dog;
  thatDog: Dog;
  photos: Photo[];

  constructor(id?: number, thisDog?: Dog, thatDog?: Dog) {
    this.id = id;
    this.thisDog = thisDog;
    this.thatDog = thatDog;
  }
}
