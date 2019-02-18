import { MatchService } from './../../services/match.service';
import { DogService } from './../../services/dog.service';
import { Matches } from './../../models/matches';
import { Dog } from './../../models/dog';
import { Component, OnInit } from '@angular/core';
import { Photo } from 'src/app/models/photo';

@Component({
  selector: 'app-matches',
  templateUrl: './matches.component.html',
  styleUrls: ['./matches.component.css']
})
export class MatchesComponent implements OnInit {
  matches: Matches[] = [];
  selectedDog: Dog;

  constructor(private dogServe: DogService, private matchServe: MatchService) { }

  ngOnInit() {
    this.selectedDog = this.dogServe.getSelectedDog();
    this.matchServe.index(this.selectedDog.id).subscribe(
      data => this.matches = data,
      err => {
        return this.matches = null;
      }
    );
    if(this.matches) {
      for (let i = 0; i < this.matches.length; i++) {
        const match = this.matches[i];
        this.dogServe.getPhotos(match.id).subscribe(
          data => match.photos = data,
        )

      }

    }
  }


}
