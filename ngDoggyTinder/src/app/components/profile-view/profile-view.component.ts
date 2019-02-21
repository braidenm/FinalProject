import { AuthService } from './../../services/auth.service';
import { UserService } from './../../services/user.service';
import { User } from 'src/app/models/user';
import { Component, OnInit } from '@angular/core';
import { ResourceLoader } from '@angular/compiler';
import { DogService } from 'src/app/services/dog.service';
import { Dog } from 'src/app/models/dog';
import { Photo } from 'src/app/models/photo';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profile-view',
  templateUrl: './profile-view.component.html',
  styleUrls: ['./profile-view.component.css']
})
export class ProfileViewComponent implements OnInit {

  constructor(private userService: UserService, private dogService: DogService,
              private router: Router, private auth: AuthService) { }

  user = new User();
  selectedDog = new Dog();
  editUser = null;
  addDog = false;
  dog = new Dog();
  photo = new Photo();
  addNewPhoto = false;
  userDogs: Dog[];


  ngOnInit() {
    this.reload();
    // this.getSelectedDog();
  }

  reload() {
    this.userService.getLoggedInUser().subscribe(
      userData => {
        this.user = userData;
        console.log(this.user.dogs);
        this.userDogs = this.user.dogs;
        this.getSelectedDog();
        this.editUser = null;
        this.addDog = false;
        this.addNewPhoto = false;
      },
      error => console.log(error)
    );
  }

  viewDogProfile(dogId: number) {
    this.router.navigateByUrl('/dogView/' + dogId);
  }

  getSelectedDog() {
    this.selectedDog = this.dogService.getSelectedDog();
  }

  selectEditUser() {
    this.editUser = this.user;
    this.addDog = false;
  }

  submitEditUser() {
    this.user = this.editUser;
    this.userService.update(this.user).subscribe(

    );
    this.editUser = null;
    this.addDog = false;
  }

  selectAddDog() {
    this.addDog = true;
    this.editUser = null;
  }

  submitAddDog() {
    this.dogService.create(this.dog, this.user.id).subscribe(
      data => {
        this.dog = data;
        this.addPhoto();
        this.addDog = false;
        this.editUser = null;
        this.selectedDog = this.dog;
        this.reload();
      },
      error => console.log(error)
    );
  }

  selectAddNewPhoto() {
    this.addNewPhoto = true;
  }

  addPhoto() {
    this.dogService.addPhoto(this.selectedDog.id, this.photo).subscribe(
      data => {
        this.addNewPhoto = false;
        console.log(this.photo.url);
        this.reload();
      },
      error => console.log(error)
    );
  }

  deleteUser() {
    this.user.active = false;
    this.userService.update(this.user);
    this.logout();
  }

  logout() {
    this.auth.logout();
    if (this.auth.getCredentials() == null) {
      console.log(
        'LogoutComponent.logout(): user logged out, routing to /home.'
      );
      this.h.setUserToNull();
      this.router.navigateByUrl('/home');
    } else {
      console.error('LogoutComponent.logout(): error logging out.');
    }
  }
}
