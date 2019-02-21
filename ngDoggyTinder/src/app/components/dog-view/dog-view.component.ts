import { MessageComponent } from './../message/message.component';
import { MessageService } from './../../services/message.service';
import { DogService } from './../../services/dog.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { UserService } from './../../services/user.service';
import { Dog } from 'src/app/models/dog';
import { ActivatedRoute, Router } from '@angular/router';
import { Preferences } from 'src/app/models/preferences';
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
  active = true;
  photos;
  isMatch = false;
  selectedDog = new Dog();
  reloadFlag = false;
  superId = null;

  constructor(private route: ActivatedRoute, private userve: UserService,
              private dogServe: DogService, private router: Router,
              private messServe: MessageService, private matchServe: MatchService,
              private messComp: MessageComponent) { }

  ngOnInit() {
    console.log('dogView Component.ngOnInit');
    this.reload();
  }

  reload() {
    console.log('dogView Component.reload');
    let dogId;
    dogId = this.route.snapshot.paramMap.get('id');
    console.log('dogId:');
    console.log(dogId);
    if (this.superId) {
      dogId = this.superId;
      this.superId = null;
    }
    this.getSelectedDog();
    this.dogServe.getOneDog(dogId).subscribe(
      dogData => {
        this.dog = dogData;
        this.active = this.dog.active;
        // if (this.reloadFlag) {
        //   this.reloadFlag = false;
        //   window.location.reload();
        // }
        this.userve.getLoggedInUser().subscribe(
          userData => {
            this.user = userData;
            // this.messServe.setThatDog(this.dog);
            this.getDogPhotos(dogId);
            this.checkIfMatch();
            for (const dog of this.user.dogs) {
                if (this.dog.id === dog.id) {
                  this.isUserDog = true;
                }
            }
            if (!this.isUserDog) {
              console.log('in if statement for is user dog at dog view');
              console.log(this.dog);


              this.messServe.setThatDog(this.dog);
              this.messComp.ngOnInit();
            }
          }
        );

      }
    );
  }

  getSelectedDog() {
    this.selectedDog = this.dogServe.getSelectedDog();
  }

  getDogPhotos(dogId: number) {
    this.dogServe.getPhotos(dogId).subscribe(
      data => {
        this.photos = data;
      }
    );
  }
  checkIfMatch() {
      this.matchServe.index(this.selectedDog.id).subscribe(
        data => {
          for (const match of data) {
            if (this.dog.id === match.thatDog.id || this.dog.id === match.thisDog.id) {
              this.isMatch = true;
              break;
            }
          }
        },
        err => {
        console.log('in err for get all matches in dog view comp');

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
    this.reload();
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

  windowReload() {
    window.location.reload();
  }


}
