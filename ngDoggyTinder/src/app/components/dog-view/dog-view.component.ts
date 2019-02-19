import { MessageService } from './../../services/message.service';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Dog } from 'src/app/models/dog';
import { ActivatedRoute, Router } from '@angular/router';
import { Preferences } from 'src/app/models/preferences';
import { Photo } from 'src/app/models/photo';
import { MatchService } from 'src/app/services/match.service';


@Component({
  selector: 'app-dog-view',
  templateUrl: './dog-view.component.html',
  styleUrls: ['./dog-view.component.css']
})
export class DogViewComponent implements OnInit {

  user: User;
  dog: Dog;
  editDog: Dog;
  isUserDog = false;
  preferences: Preferences;
  active = false;
  photos;
  isMatch = false;

  constructor(private route: ActivatedRoute, private userve: UserService,
              private dogServe: DogService, private router: Router,
              private messServe: MessageService, private matchServe: MatchService) { }

  ngOnInit() {
    this.reload();
  }
  reload() {
    let dogId;
    dogId = this.route.snapshot.paramMap.get('id');
    this.dogServe.getOneDog(dogId).subscribe(
      dogData => {
        this.dog = dogData;
        this.active = this.dog.active;
        this.userve.getLoggedInUser().subscribe(
          userData => {
            this.user = userData;
            this.messServe.setThatDog(this.dog);
            console.log(this.user);
            this.getDogPhotos(dogId);
            console.log(this.photos);
            for (const dog of this.user.dogs) {
                if (this.dog.id === dog.id) {
                  this.isUserDog = true;
                }
            }
            this.checkIfMatch();
          }
        );

        if (!this.isUserDog) {
          this.messServe.setThatDog(this.dog);
        }
      }
    );
  }

  getDogPhotos(dogId: number) {
    this.dogServe.getPhotos(dogId).subscribe(
      data => {
        this.photos = data;
        console.log(data);
      }
    );
  }
  checkIfMatch() {
      this.matchServe.index(this.dogServe.getSelectedDog().id).subscribe(
        data => {
          console.log(this.dogServe.getSelectedDog());
          for (const match of data) {
            if (this.dog.id === match.thatDog.id) {
              this.isMatch = true;
              break;
            }
         }
      }
    );
  }

  setEditDog() {
    this.editDog = this.dog;
  }

  cancelEditDog() {
    this.editDog = null;
  }
  confirmEditDog() {
    this.dog = this.editDog;
    this.dogServe.update(this.dog).subscribe(
    );
    this.editDog = null;
  }
  deactivateDog() {
    this.dog.active = false;
    this.active = false;
    this.dogServe.update(this.dog).subscribe(
      data => {
        this.dog = data;
        this.reload();
      }
    );
  }
  reactivateDog() {
    this.dog.active = true;
    this.active = true;
    this.dogServe.update(this.dog).subscribe(
      data => {
        this.dog = data;
        this.reload();
      }
        );
  }
  setEditPref() {
    this.dogServe.showPreferences(this.dog.id).subscribe(
      data => {
        this.preferences = data;
        this.reload();
      }
    );
  }
  cancelEditPref() {
    this.preferences = null;
  }

  confirmEditPref() {
    this.dogServe.updatePref(this.dog.id, this.preferences).subscribe();
    this.preferences = null;
  }

}
