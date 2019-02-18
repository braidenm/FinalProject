import { Likes } from './../../models/likes';
import { DisLikeService } from './../../services/dis-like.service';
import { LikeService } from './../../services/like.service';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { Dog } from 'src/app/models/dog';
import { forEach } from '@angular/router/src/utils/collection';
import { MatchService } from 'src/app/services/match.service';
import { Matches } from 'src/app/models/matches';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  likes: Likes[];
  dogs = [];
  selectedDog = new Dog();
  matches: Matches[];
  popUpDog = new Dog();

  constructor(private matchService: MatchService, private dogService: DogService,
              private likeService: LikeService, private disLikeService: DisLikeService) { }

  ngOnInit() {
    this.selectedDog = this.dogService.getSelectedDog();
    this.loadMatches(this.selectedDog.id);
    // this.dogs = this.getAllDogs();
  }

  getAllDogs() {
    this.dogService.index().subscribe(
      data => {

      },
      error => console.log(error)
    );
  }

  loadMatches(selectedDogId: number) {
    this.matchService.index(selectedDogId).subscribe(
      data => {
        this.matches = data;
      },
      error => console.log(error)
    );
  }

  likeDog(thatDogId: number) {
    this.likeService.addLike(this.selectedDog.id, thatDogId).subscribe(
      data => {
        this.likeService.getByThisDog(thatDogId).subscribe(
          likeList => {
            likeList.forEach(like => {
              if (like.thatDog.id === this.selectedDog.id) {
                this.matchService.addMatch(like.thatDog.id, thatDogId);
                this.loadMatches(this.selectedDog.id);
                this.popUpCaller(thatDogId);
              }

            });
          },
          error => console.log(error)
        );
        this.loadMatches(this.selectedDog.id);
      },
      error => console.log(error)
    );
  }

  dislikeDog(thatDogId: number) {
    this.disLikeService.addDislike(this.selectedDog.id, thatDogId).subscribe(
      data => {
        this.loadMatches(this.selectedDog.id);
      },
      error => console.log(error)
    );
  }

  popUpCaller(thatDogId: number) {
    this.dogService.getOneDog(thatDogId).subscribe(
      data => {
        this.popUpDog = data;
      },
      error => console.log(error)
    );
  }




}
