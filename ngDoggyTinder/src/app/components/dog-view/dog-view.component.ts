import { MessageService } from './../../services/message.service';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Dog } from 'src/app/models/dog';
import { ActivatedRoute, Router } from '@angular/router';
import { Preferences } from 'src/app/models/preferences';


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

  constructor(private route: ActivatedRoute, private userve: UserService,
              private dogServe: DogService, private router: Router,
              private messServe: MessageService) { }

  ngOnInit() {
    let dogId;
    dogId = this.route.snapshot.paramMap.get('id');
    this.dogServe.getOneDog(dogId).subscribe(
      dogData => this.dog = dogData
    );
    this.userve.getLoggedInUser().subscribe(
      userData => this.user = userData
    );
    this.getUserDogs();
    this.getDogPhotos(dogId);

    for (const dog of this.user.dogs) {
        if (this.dog.id === dog.id) {
          this.isUserDog = true;
        }
    }
    if (!this.isUserDog) {
      this.messServe.setThatDog(this.dog);
    }

    console.log(this.user);
  }

  getUserDogs() {
    this.dogServe.getAllByUser(this.user.id).subscribe(
      data => this.user.dogs = data
    );
  }

  getDogPhotos(dogId) {
    this.dogServe.getPhotos(dogId).subscribe(
      data => this.dog.photos = data
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
      data => this.dog = data
    );
    this.editDog = null;
  }
  deactivateDog() {
    this.dog.active = false;
    this.dogServe.update(this.dog).subscribe(
      data => this.dog = data
    );
  }
  reactivateDog() {
    this.dog.active = true;
    this.dogServe.update(this.dog).subscribe(
      data => this.dog = data
    );
  }
  setEditPref() {
    this.dogServe.showPreferences(this.dog.id).subscribe(
      data => this.preferences = data
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
