import { Matches } from './../models/matches';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { User } from '../models/user';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Dog } from '../models/dog';

@Injectable({
  providedIn: 'root'
})
export class MatchService {

   // Fields
   private baseUrl = environment.baseUrl;
   private url = this.baseUrl + 'api/matches';

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

   index(dogId: number) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.get<Matches[]>(this.url + '/' + dogId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

   delete(thisdogId: number, thatDogId) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.delete<Dog>(this.url + '/' + thisdogId + '/' + thatDogId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

   addMatch(thisdogId: number, thatDogId) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.post<Dog>(this.url + '/' + thisdogId + '/' + thatDogId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }


}
