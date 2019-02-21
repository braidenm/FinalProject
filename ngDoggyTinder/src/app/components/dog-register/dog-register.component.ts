import { UserService } from 'src/app/services/user.service';
import { Dog } from './../../models/dog';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Photo } from 'src/app/models/photo';
import { User } from 'src/app/models/user';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dog-register',
  templateUrl: './dog-register.component.html',
  styleUrls: ['./dog-register.component.css']
})
export class DogRegisterComponent implements OnInit {

  newDog = null;
  dog = new Dog();
  photo = new Photo();
  user =  new User();

  constructor(private dogService: DogService, private userService: UserService,
              private router: Router) { }


  ngOnInit() {
    this.userService.getLoggedInUser().subscribe(
      data => {
        this.user = data;
      },
      error => console.log(error)
    );
  }

  addDog() {
    this.dogService.create(this.dog, this.user.id).subscribe(
      data => {
        this.dog = data;
        this.dogService.setSelectedDog(this.dog);
        this.addPhoto();
        this.router.navigateByUrl('home');
      },
      error => console.log(error)
    );
  }

  addPhoto() {
    this.dogService.addPhoto(this.dog.id, this.photo).subscribe(
      data => {
      },
      error => console.log(error)
    );
  }



}
