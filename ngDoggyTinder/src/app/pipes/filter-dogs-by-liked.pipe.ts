import { Likes } from '../models/likes';
import { Pipe, PipeTransform } from '@angular/core';
import { Dog } from '../models/dog';

@Pipe({
  name: 'filterDogsByLikedPipe'
})
export class FilterDogsByLikedPipe implements PipeTransform {

  transform(dogs: Dog[], likes: Likes[]): any {
    const results = [];

    dogs.forEach((dog) => {
      likes.forEach((like) => {
        if (like.thatDog.id !== dog.id) {
          results.push(dog);
        }
      });
    });

    return results;
  }

}
