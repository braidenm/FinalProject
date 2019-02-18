import { Dog } from './../../models/dog';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Photo } from 'src/app/models/photo';

@Component({
  selector: 'app-dog-register',
  templateUrl: './dog-register.component.html',
  styleUrls: ['./dog-register.component.css']
})
export class DogRegisterComponent implements OnInit {

  newDog = null;
  dog = new Dog();
  photo = new Photo();

  constructor(private dogService: DogService) { }


  ngOnInit() {
  }

  addDog() {
    this.dogService.create(this.dog, userId).subscribe(
      data => {
        this.dog = data;
        this.addPhoto();
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
