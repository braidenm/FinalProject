import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { User } from '../models/user';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Likes } from '../models/likes';
import { Dog } from '../models/dog';

@Injectable({
  providedIn: 'root'
})
export class LikeService {
 // Fields
 private baseUrl = environment.baseUrl;
 private url = this.baseUrl + 'api/dogs/likes';

 // Constructor
 constructor(private http: HttpClient, private router: Router, private auth: AuthService) { }

 // Methods
 getHttp() {
   const credentials = this.auth.getCredentials();
   console.log(credentials);
   return {
     headers: {
       Authorization: `Basic ${credentials}`,
       'Content-Type': 'application/json',
       'X-Requested-With': 'XMLHttpRequest'
     }
   };
 }

 index() {
   if (!this.auth.checkLogin) {
     this.router.navigateByUrl('login');
   }
   return this.http.get<Likes[]>(this.url, this.getHttp())
   .pipe(
         catchError((err: any) => {
           console.log(err);
           return throwError('KABOOM broken at like service index');
         })
    );
 }

 getByThatDog(thatDogId: number) {
   if (!this.auth.checkLogin) {
     this.router.navigateByUrl('login');
   }
   return this.http.get<Likes[]>(this.url + '/thatDog/' + thatDogId, this.getHttp())
   .pipe(
         catchError((err: any) => {
           console.log(err);
           return throwError('KABOOM broken at like service getByThatDog');
         })
    );
 }
 getByThisDog(thisDogId: number) {
   if (!this.auth.checkLogin) {
     this.router.navigateByUrl('login');
   }
   return this.http.get<Likes[]>(this.url + '/thisDog/' + thisDogId, this.getHttp())
   .pipe(
         catchError((err: any) => {
           console.log(err);
           return throwError('KABOOM broken at like service getByThisDog');
         })
    );
 }
 addLike(thisDogId: number, thatDogId: number) {
   if (!this.auth.checkLogin) {
     this.router.navigateByUrl('login');
     console.log('in addLikeIfStatement');
    }
   console.log(this.getHttp());
   return this.http.get<Dog>(this.url + '/' + thisDogId + '/' + thatDogId, this.getHttp())
   .pipe(
         catchError((err: any) => {
           console.log(err);
           return throwError('KABOOM broken at like service addlike');
         })
    );
 }
}
// @PostMapping("dogs/likes/{thisId}/{thatId}")
