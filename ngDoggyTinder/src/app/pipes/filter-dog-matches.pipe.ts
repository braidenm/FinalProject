import { MatchService } from './../services/match.service';
import { Pipe, PipeTransform } from '@angular/core';
import { Dog } from '../models/dog';

@Pipe({
  name: 'filterDogMatches'
})
export class FilterDogMatchesPipe implements PipeTransform {
  constructor(private mService: MatchService) {}

  transform(dogs: Dog[], selectedDog: Dog): any {
    const results = [];
    this.mService.index(selectedDog.id).subscribe(data => {
      for (const dog of dogs) {
        for (const match of data) {
          if (dog.id !== match.thatDog.id || dog.id !== match.thisDog.id) {
            results.push(dog);
          }
        }
      }
      return results;
    });
  }
}
