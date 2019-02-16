import { Dog } from './dog';

export class Photo {

  id: number;
  dog: Dog;
  url: string;

  constructor(id?: number, dog?: Dog, url?: string){
    this.id = id;
    this.dog = dog;
    this.url = url;
  }
}
