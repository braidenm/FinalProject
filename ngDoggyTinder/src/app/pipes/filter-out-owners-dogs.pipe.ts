import { Pipe, PipeTransform } from '@angular/core';
import { User } from '../models/user';
import { Dog } from '../models/dog';

@Pipe({
  name: 'filterOutOwnersDogs'
})
export class FilterOutOwnersDogsPipe implements PipeTransform {

  transform(dogs: Dog[], user: User): any {
    const results = [];
    const ownersDogs = user.dogs;
    filterStart:
    for (const dog of dogs) {
    for (const od of ownersDogs) {
          if (dog !== od) {
            results.push(dog);
          }
        }
    }
    return results;
  }

}
