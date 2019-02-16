import { Dog } from './dog';

export class Message {

  id: number;
  thisDog: Dog;
  thatDog: Dog;
  text: string;
  date: Date;

  constructor(id?: number, thisDog?: Dog, thatDog?: Dog, date?: Date) {
    this.id = id;
    this.thisDog = thisDog;
    this.thatDog = thatDog;
    this.date = date;
  }
}
