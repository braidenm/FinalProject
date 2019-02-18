import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterDogsByDislike'
})
export class FilterDogsByDislikePipe implements PipeTransform {

  transform(value: any, args?: any): any {
    return null;
  }

}
