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

  private user: User;

  constructor(private http: HttpClient) {}
  getCredentials() {
    return localStorage.getItem('credentials');
  }

  checkLogin() {
    if (localStorage.getItem('credentials')) {
      return true;
    }
    return false;
  }

  login(username, password) {
    console.log(username + password);

    // Make credentials
    const credentials = this.generateBasicAuthCredentials(username, password);
    console.log(credentials);

    // Send credentials as Authorization header (this is spring security convention for basic auth)
    const httpOptions = {
      headers: new HttpHeaders({
        Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
    // create request to authenticate credentials
    return this.http.get(this.baseUrl + 'authenticate', httpOptions).pipe(
      tap(res => {
        localStorage.setItem('credentials', credentials);
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('AuthService.login(): Error logging in.');
      })
    );
  }


  register(user) {
    // create request to register a new account
    const credentials = this.generateBasicAuthCredentials(user.username, user.password);
    console.log(user.name + 'in register');
    console.log(user);
    console.log(credentials);

    const httpOptions = {
      headers: new HttpHeaders({
        // Authorization: `Basic ${credentials}`,
        'X-Requested-With': 'XMLHttpRequest'
      })
    };
    return this.http.post(this.baseUrl + 'register', user, httpOptions)
    .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('AuthService.register(): error registering user.');
        })
      );
  }

  logout() {
    localStorage.removeItem('credentials');
  }

  generateBasicAuthCredentials(username, password) {
    return btoa(`${username}:${password}`);
  }
}
