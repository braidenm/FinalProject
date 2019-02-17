import { DisLike } from './../models/dis-like';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Dog } from '../models/dog';

@Injectable({
  providedIn: 'root'
})
export class DisLikeService {

  // Fields
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/dogs/dislikes';
  // Constructor
  constructor(private http: HttpClient, private router: Router, private auth: AuthService) { }

  // Methods
  getHttp() {
    const credentials = this.auth.getCredentials();
    return {
      headers: {
        Authorization: `Basic ${credentials}`,
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    };
  }

  index() {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<DisLike[]>(this.url, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  getByThatDog(thatDogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<DisLike[]>(this.url + '/thatDog/' + thatDogId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
  getByThisDog(thisDogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<DisLike[]>(this.url + '/thisDog/' + thisDogId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
  addLike(thisDogId: number, thatDogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Dog>(this.url + '/' + thisDogId + '/' + thatDogId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
}
