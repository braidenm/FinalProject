import { MatchService } from './../../services/match.service';
import { DogService } from './../../services/dog.service';
import { Matches } from './../../models/matches';
import { Dog } from './../../models/dog';
import { Component, OnInit } from '@angular/core';
import { Photo } from 'src/app/models/photo';
import { Router } from '@angular/router';

@Component({
  selector: 'app-matches',
  templateUrl: './matches.component.html',
  styleUrls: ['./matches.component.css']
})
export class MatchesComponent implements OnInit {
  matches: Matches[] = [];
  selectedDog: Dog;
  dogs: Dog[] = [];

  constructor(private dogServe: DogService, private matchServe: MatchService, private router: Router) { }

  ngOnInit() {
    this.selectedDog = this.dogServe.getSelectedDog();
    this.matchServe.index(this.selectedDog.id).subscribe(
      data => {
        this.matches = data;
        this.filterMatches();
        console.log(data);
      },
      err => {
        return this.matches = null;
      }
    );
    if (this.matches) {
      for (const match of this.matches) {
        this.dogServe.getPhotos(match.id).subscribe(
          data => match.photos = data,
        );
      }
    }
  }

  filterMatches() {
    for (const match of this.matches) {
      if (this.selectedDog.id !== match.thatDog.id) {
        this.dogs.push(match.thatDog);
      }
      if (this.selectedDog.id !== match.thisDog.id) {
        this.dogs.push(match.thisDog);
      }
    }
  }

  viewDogProfile(dogId: number) {
    this.router.navigateByUrl('/dogView/' + dogId);
  }


}
