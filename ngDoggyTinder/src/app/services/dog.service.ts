import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { AuthService } from './auth.service';
import { User } from '../models/user';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Dog } from '../models/dog';
import { Preferences } from '../models/preferences';
import { Photo } from '../models/photo';

@Injectable({
  providedIn: 'root'
})
export class DogService {
  // Fields
  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + 'api/dogs';
  private selectedDog: Dog;

  // Constructor
  constructor(private http: HttpClient, private router: Router, private auth: AuthService) { }

  // Methods

  setSelectedDog(dog: Dog) {
        this.selectedDog = dog;
  }

  getSelectedDog() {
    return this.selectedDog;
  }
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
    return this.http.get<Dog[]>(this.url, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at dog service index');
          })
     );
  }

  getOneDog(dogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Dog>(this.url + '/' + dogId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at getOneDog');
          })
     );
  }

  showPreferences(dogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Preferences>(this.url + '/' + dogId + '/pref', this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at show preferences');
          })
     );
  }

  delete(dogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.delete(this.url + '/' + dogId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at delete');
          })
     );
  }

  create(dog: Dog, userId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.post<Dog>(this.url + '/' + userId, dog, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at create');
          })
     );
  }
  update(dog: Dog) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.put<Dog>(this.url, dog, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at update dog');
          })
     );
  }
  getAllByUser(userId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Dog[]>(this.url + '/users/' + userId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at getallbyuser');
          })
     );
  }
  findByName(name: string) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Dog[]>(this.url + '/name/' + name, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at findbyname');
          })
     );
  }
  findByBreed(breed: string) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Dog[]>(this.url + '/breed/' + breed, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at findByBreed');
          })
     );
  }
  updatePref(dogId: number, preferences: Preferences) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.put<Dog>(this.url + '/' + dogId + '/pref', preferences, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at updatePref');
          })
     );
  }
  addPhoto(dogId: number, photo: Photo) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.post<Dog>(this.url + '/' + dogId + '/photo', photo, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken addPhoto');
          })
     );
  }
  deletePhoto(dogId: number, photoId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.post<Dog>(this.url + '/' + dogId + '/photo/' + photoId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at deletePhoto');
          })
     );
  }
  getPhotos(dogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.get<Photo[]>(this.url + '/' + dogId + '/photo', this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at getPhotos');
          })
     );
  }
}
