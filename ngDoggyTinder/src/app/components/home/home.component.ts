import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  dogs = [];

  constructor(private dogService: DogService) { }

  ngOnInit() {
  }

  getAllDogs() {
    this.dogService.index().subscribe(
      data => {

      },
      error => console.log(error)
    );
  }



}
