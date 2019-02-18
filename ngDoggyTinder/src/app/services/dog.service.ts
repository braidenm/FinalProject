import { DogService } from './dog.service';
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

  setSelectedDog(dogId: number) {
    this.getOneDog(dogId).subscribe(
      data => this.selectedDog = data,
      err => {
        this.router.navigateByUrl('notFound');
      }
    );
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  create(dog: Dog, userId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.post<Dog>(this.url + '/users/' + userId, dog, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
  getAllByUser(userId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.put<Dog[]>(this.url + '/users/' + userId, this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
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
            return throwError('KABOOM broken at todo service index');
          })
     );
  }
  getPhotos(dogId: number) {
    // if (!this.auth.checkLogin) {
    //   this.router.navigateByUrl('login');
    // }
    return this.http.post<Photo[]>(this.url + '/' + dogId + '/photo', this.getHttp())
    .pipe(
          catchError((err: any) => {
            console.log(err);
            return throwError('KABOOM broken at todo service index');
          })
     );
  }

  addLikedDog(dog: Dog) {
    this.selectedDog

  }
}
