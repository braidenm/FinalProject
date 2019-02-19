import { Pipe, PipeTransform } from '@angular/core';
import { Dog } from '../models/dog';

@Pipe({
  name: 'filterDogsByActive'
})
export class FilterDogsByActivePipe implements PipeTransform {

  transform(dogs: Dog[]): any {
    const results = [];
    dogs.forEach((dog) => {
      if (dog.active) {
        results.push(dog);
      }
    });

    return results;
  }

}
