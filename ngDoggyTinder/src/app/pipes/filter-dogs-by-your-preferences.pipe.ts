import { Dog } from 'src/app/models/dog';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterDogsByYourPreferences'
})
export class FilterDogsByYourPreferencesPipe implements PipeTransform {

  transform(dogs: Dog[], selectedDog: Dog): any {
    const results = [];

    dogs.forEach((dog) => {
      if (dog.age >= selectedDog.Preferences.minAge && dog.age <= selectedDog.Preferences.maxAge) {
        if (dog.weight >= selectedDog.Preferences.minWeight && dog.weight <= selectedDog.Preferences.maxWeight) {
          if (dog.energy >= selectedDog.Preferences.minEnergy && dog.energy <= selectedDog.Preferences.maxEnergy) {
        results.push(dog);
          }
        }
      }
    });
    return results;
  }

}
