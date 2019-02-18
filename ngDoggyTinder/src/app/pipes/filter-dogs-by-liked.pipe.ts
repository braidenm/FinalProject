import { Likes } from '../models/likes';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'filterDogsByLikedPipe'
})
export class FilterDogsByLikedPipe implements PipeTransform {

  transform(likes: Likes[], thisDogId: number, thatDogId: number): any {


    return null;
  }

}
