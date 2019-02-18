import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { catchError, tap } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private baseUrl = environment.baseUrl;

  constructor(private http: HttpClient) { }
  getCredentials() {
    return localStorage.getItem('credentials');
  }

  checkLogin() {

  }

  login(username, password) {
       // Make credentials
       const credentials = this.generateBasicAuthCredentials(username, password);
       // Send credentials as Authorization header (this is spring security convention for basic auth)
       const httpOptions = {
         headers: new HttpHeaders({
           Authorization: `Basic ${credentials}`,
           'X-Requested-With': 'XMLHttpRequest'
         })
       };
      // create request to authenticate credentials
       return this.http
      .get(this.baseUrl + 'authenticate', httpOptions)
      .pipe(
        tap((res) => {
          localStorage.setItem('credentials', credentials);
          return res;
        }),
        catchError((err: any) => {
          console.log(err);
          return throwError('AuthService.login(): Error logging in.');
        })
      );

  }

  register(user: User) {

  }
  logout() {

  }
  generateBasicAuthCredentials(username, password) {

  }
}
