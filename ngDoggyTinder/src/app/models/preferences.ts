import { Dog } from "./dog";

export class Preferences {
  id: number;
  dog: Dog;
  minWeight: number;
  maxWeight: number;
  minEnergy: number;
  maxEnergy: number;
  minAge: number;
  maxAge: number;
  sex: number;

  constructor(
    id?: number,
    dog?: Dog,
    minWeight?: number,
    maxWeight?: number,
    minEnergy?: number,
    maxEnergy?: number,
    minAge?: number,
    maxAge?: number,
    sex?: number
  ) {
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
