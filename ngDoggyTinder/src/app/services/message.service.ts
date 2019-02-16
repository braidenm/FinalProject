import { Message } from './../models/message';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class MessageService {

   // Fields
   private baseUrl = environment.baseUrl;
   private url = this.baseUrl + 'api/messages';

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

   add(text: string, senderId: number, receiverId: number) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.post<Message>(this.url + '/' + text + '/' + senderId + '/' + receiverId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

   getConversation(senderId: number, receiverId: number) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.get<Message[]>(this.url + '/' + senderId + '/' + receiverId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

   findByReceiver(receiverId: number) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.get<Message[]>(this.url + '/receiver/' + receiverId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

   findBySender(senderId: number) {
     // if (!this.auth.checkLogin) {
     //   this.router.navigateByUrl('login');
     // }
     return this.http.get<Message[]>(this.url + '/sender/' + senderId, this.getHttp())
     .pipe(
           catchError((err: any) => {
             console.log(err);
             return throwError('KABOOM broken at todo service index');
           })
      );
   }

}
