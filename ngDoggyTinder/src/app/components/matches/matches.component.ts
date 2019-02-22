import { DogViewComponent } from './../dog-view/dog-view.component';
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
  dogId: number;

  constructor(private dogServe: DogService, private matchServe: MatchService, private router: Router, private dvComp: DogViewComponent) { }

  ngOnInit() {
    this.reload();
  }
  reload() {
    console.log('matches has started');
    this.selectedDog = this.dogServe.getSelectedDog();
    console.log(this.selectedDog + ' has been grabbed');
    this.matchServe.index(this.selectedDog.id).subscribe(
      data => {
        this.matches = data;
        this.filterMatches();
        console.log(data);
        if (this.dogId) {
          this.router.navigateByUrl('/dogView/' + this.dogId);
          // this.dvComp.reloadFlag = true;
          this.dvComp.superId = this.dogId;
          this.dvComp.reload();
        }
      },
      err => {
        return this.matches = null;
      }
    );
    // if (this.matches) {
    //   for (const match of this.matches) {
    //     this.dogServe.getPhotos(match.id).subscribe(
    //       data => match.photos = data,
    //     );
    //   }
    // }
  }

  filterMatches() {
    this.dogs = [];
    for (const match of this.matches) {
      if (this.selectedDog.id !== match.thatDog.id) {
        this.dogs.push(match.thatDog);
      }
      if (this.selectedDog.id !== match.thisDog.id) {
        this.dogs.push(match.thisDog);
      }
    }
  }

  viewDogProfile(dogid: number) {
    this.dogId = dogid;
    this.dvComp.reload();
    this.reload();
  }

}
