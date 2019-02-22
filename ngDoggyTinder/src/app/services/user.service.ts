import { AuthService } from './auth.service';
import { environment } from 'src/environments/environment';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { User } from '../models/user';
import { throwError } from 'rxjs';
import { catchError} from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  // Fields
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/users';

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
    // if (!this.auth.checkLogin()) {
    //   this.router.navigateByUrl('register');
    // }
    return this.http.get<User[]>(this.url, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  getById(id: number) {
    // if (!this.auth.checkLogin()) {
    //   this.router.navigateByUrl('register');
    // }
    return this.http.get<User>(this.url + '/' + id, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
  getLoggedInUser() {
    // if (!this.auth.checkLogin()) {
    //   console.log('failed checklogin in user service line 60');

    //   this.router.navigateByUrl('register');
    // }

    return this.http.get<User>(this.url + '/username', this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  update(user: User) {
    console.log('in update user');
    console.log(user);
    // if (!this.auth.checkLogin()) {
    //   this.router.navigateByUrl('register');
    // }
    return this.http.put<User>(this.url , user, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  delete(id: number) {
    if (!this.auth.checkLogin()) {
      this.router.navigateByUrl('register');
    }
    return this.http.delete<User>(this.url + '/' + id, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

}
