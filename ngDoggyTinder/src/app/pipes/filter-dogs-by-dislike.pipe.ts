import { DisLike } from './../models/dis-like';
import { Pipe, PipeTransform } from '@angular/core';
import { Dog } from '../models/dog';

@Pipe({
  name: 'filterDogsByDislike'
})
export class FilterDogsByDislikePipe implements PipeTransform {

    transform(dogs: Dog[], dislikes: DisLike[], selectedDog: Dog): any {
    const results = [];

    dogs.forEach((dog) => {
      dislikes.forEach((dislike) => {
        if (dislike.thatDog.id !== dog.id && dislike.thatDog.id !== selectedDog.id) {
          results.push(dog);
        }
      });
    });
  }
}
}
