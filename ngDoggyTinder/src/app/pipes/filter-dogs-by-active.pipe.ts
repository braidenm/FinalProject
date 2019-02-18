import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterDogsByActive'
})
export class FilterDogsByActivePipe implements PipeTransform {

  transform(value: any, args?: any): any {
    return null;
  }

}
