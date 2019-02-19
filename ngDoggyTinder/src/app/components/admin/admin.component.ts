import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { DogService } from 'src/app/services/dog.service';
import { Dog } from 'src/app/models/dog';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  constructor(private userService: UserService, private dogService: DogService) { }

  dogs: Dog[];
  users: User[];
  dog = new Dog();
  user = new User();
  userDetailView = false;
  dogDetailView = false;

  ngOnInit() {
  }

  loadUsers() {
    this.userService.index().subscribe(
      userData => {
        this.users = userData;
        console.log(this.users);
        this.dogs = null;
        this.userDetailView = false;
        this.dogDetailView = false;

      },
      error => console.log(error)
    );
  }

  loadDogs() {
    this.dogService.index().subscribe(
      dogData => {
        this.dogs = dogData;
        console.log(this.dogs);
        this.users = null;
        this.userDetailView = false;
        this.dogDetailView = false;


      },
      error => console.log(error)
    );
  }

  selectUserDetailView(editUser: User) {
    this.user = editUser;
    this.userDetailView = true;
  }

  selectDogDetailView(editDog: Dog) {
    this.dog = editDog;
    this.dogDetailView = true;
  }

  deactivateDog() {
    this.dog.active = false;
    this.dogService.update(this.dog);
  }

  activateDog() {
    this.dog.active = true;
    this.dogService.update(this.dog);
  }

  deactivateUser() {
    this.user.active = false;
    this.userService.update(this.user);
  }

  activateUser() {
    this.user.active = true;
    this.userService.update(this.user);
  }

  ban() {
    this.user.banned = true;
    this.userService.update(this.user);
  }

  unban() {
    this.user.banned = false;
    this.userService.update(this.user);
  }


}
