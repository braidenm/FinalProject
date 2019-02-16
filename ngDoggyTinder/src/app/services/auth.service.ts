import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor() { }
  getCredentials() {
    return localStorage.getItem('credentials');
  }
}
