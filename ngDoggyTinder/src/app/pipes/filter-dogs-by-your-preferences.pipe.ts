import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterDogsByYourPreferences'
})
export class FilterDogsByYourPreferencesPipe implements PipeTransform {

  transform(value: any, args?: any): any {
    return null;
  }

}
