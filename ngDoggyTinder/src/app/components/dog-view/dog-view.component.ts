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

  user: User = new User();
  dog: Dog = new Dog();
  editDog: Dog = null;
  isUserDog = false;
  preferences: Preferences = null;
  active = true;
  photos = [];
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
    // this.user = new User();
    // this.dog = new Dog();
    // this.editDog = null;
    // this.isUserDog = false;
    // this.preferences = null;
    // this.active = true;
    // this.photos = [];
    // this.isMatch = false;
    // this.selectedDog = new Dog();
    // this.reloadFlag = false;
    // this.superId = null;
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
            console.log(this.user);
            // this.messServe.setThatDog(this.dog);
            for (const dog of this.user.dogs) {
              if (this.dog.id === dog.id) {
                this.isUserDog = true;
              }
            }

            this.checkIfMatch();
            if (!this.isUserDog) {
              console.log('in if statement for is user dog at dog view');
              console.log(this.dog);


              this.messServe.setThatDog(this.dog);
              this.messComp.ngOnInit();
            }
          },
          err => {
            console.log('in get logged in user error');

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
          this.getDogPhotos(this.dog.id);
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
    // this.reload();
    // window.location.reload();
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
    this.reload();
  }

  windowReload() {
    window.location.reload();
  }


}
