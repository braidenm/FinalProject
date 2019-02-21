import { AuthService } from 'src/app/services/auth.service';
import { FilterOutOwnersDogsPipe } from './../../pipes/filter-out-owners-dogs.pipe';
import { FilterDogsByActivePipe } from './../../pipes/filter-dogs-by-active.pipe';
import { FilterDogsByDislikePipe } from './../../pipes/filter-dogs-by-dislike.pipe';
import { FilterDogMatchesPipe } from './../../pipes/filter-dog-matches.pipe';
import { UserService } from './../../services/user.service';
import { DisLike } from './../../models/dis-like';
import { Likes } from './../../models/likes';
import { DisLikeService } from './../../services/dis-like.service';
import { LikeService } from './../../services/like.service';
import { DogService } from './../../services/dog.service';
import { OnInit, Component } from '@angular/core';
import { Dog } from 'src/app/models/dog';
import { forEach } from '@angular/router/src/utils/collection';
import { MatchService } from 'src/app/services/match.service';
import { Matches } from 'src/app/models/matches';
import { User } from 'src/app/models/user';
import { FilterDogsByYourPreferencesPipe } from 'src/app/pipes/filter-dogs-by-your-preferences.pipe';
import { FilterDogsByLikedPipe } from 'src/app/pipes/filter-dogs-by-liked.pipe';
import { Route, Router } from '@angular/router';
import { filter } from 'rxjs/operators';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  user: User = null;
  // likes: Likes[];
  dogs: Dog[] = null; // [];
  selectedDog = new Dog();
  matches: Matches[];
  popUpDog = new Dog();
  // dislikes: DisLike[];
  possibleMatches: Dog[] = [];
  filteredDogs: Dog[] = [];

  closeResult: string;
  dogId: number;

  constructor(
    private matchService: MatchService,
    private dogService: DogService,
    private likeService: LikeService,
    private disLikeService: DisLikeService,
    private userS: UserService,
    private auth: AuthService,
    private router: Router,
    private modalService: NgbModal,
  ) // private route: Route,
  // private matchpipe: FilterDogMatchesPipe,
  // private prefPipe: FilterDogsByYourPreferencesPipe,
  // private likedPipe: FilterDogsByLikedPipe,
  // private dislikedPipe: FilterDogsByDislikePipe,
  // private activePipe: FilterDogsByActivePipe,
  // private filterOutOwner: FilterOutOwnersDogsPipe
  {}

  ngOnInit() {
    if (this.auth.checkLogin()) {
      this.getAllDogs();
    }
  }
  // this is working properly
  getUser() {
    this.userS.getLoggedInUser().subscribe(data => {
      this.user = data;
      if (this.user.dogs.length === 0) {
        this.router.navigateByUrl('dogRegister');
      }
      this.selectedDog = this.dogService.getSelectedDog();
      this.dogService
        .getFilteredDogs(this.selectedDog.id)
        .subscribe(dogList => {
          this.filteredDogs = dogList;
          // this.getDogsThatLikeThisDog();
        });
    });
  }

  // this is working properly
  getAllDogs() {
    this.dogService.index().subscribe(
      data => {
        this.dogs = data;
        this.getUser();
      },
      error => {
        console.log(error);
      }
    );
  }

  loadMatches(selectedDogId: number) {
    this.matchService.index(selectedDogId).subscribe(
      data => {
        console.log('yoooooo');
        this.matches = data;
      },
      error => console.log(error)
    );
  }

  // loadLikes(selectedDogId: number) {
  //   this.likeService.getByThisDog(selectedDogId).subscribe(
  //     data => {
  //       this.likes = data;
  //       this.getDogsByFilter();
  //     },
  //     error => console.log(error)
  //   );
  // }

  // loadDislikes(selectedDogId: number) {
  //   this.disLikeService.index().subscribe(
  //     data => {
  //       this.dislikes = data;
  //       this.loadLikes(this.selectedDog.id);

  //     },
  //     error => console.log(error)
  //   );
  // }

  // likeDog(thatDogId: number) {
  //   this.likeService.addLike(this.selectedDog.id, thatDogId).subscribe(
  //     data => {
  //       this.likeService.getByThisDog(thatDogId).subscribe(
  //         likeList => {
  //           for (const like of likeList) {
  //             if (like.thatDog.id === this.selectedDog.id) {
  //               this.matchService.addMatch(like.thatDog.id, thatDogId);

  //               this.dogService
  //                 .getFilteredDogs(this.selectedDog.id)
  //                 .subscribe(dogList => {
  //                   this.filteredDogs = dogList;
  //                   this.loadMatches(this.selectedDog.id);
  //                   this.popUpCaller(thatDogId);
  //                 });
  //             }
  //           }
  //           this.getAllDogs();
  //           // likeList.forEach(like => {
  //           //   if (like.thatDog.id === this.selectedDog.id) {
  //           //     this.matchService.addMatch(like.thatDog.id, thatDogId);
  //           //     this.loadMatches(this.selectedDog.id);
  //           //     this.popUpCaller(thatDogId);
  //           //   }
  //         },
  //         error => console.log(error)
  //       );
  //       this.loadMatches(this.selectedDog.id);
  //     },
  //     error => console.log(error)
  //   );
  // }

  dislikeDog(thatDogId: number) {
    this.disLikeService.addDislike(this.selectedDog.id, thatDogId).subscribe(
      data => {
        this.filteredDogs = null;
        this.dogService
        .getFilteredDogs(this.selectedDog.id)
        .subscribe(filtered => {
          this.filteredDogs = filtered;
        });
      },
      error => console.log(error)
    );
  }

  // popUpCaller(thatDogId: number) {
  //   this.dogService.getOneDog(thatDogId).subscribe(
  //     data => {
  //       this.popUpDog = data;
  //     },
  //     error => console.log(error)
  //   );
  // }

  // getDogsThatLikeThisDog() {
  //   this.likeService.getByThatDog(this.selectedDog.id).subscribe(data => {
  //     this.possibleMatches = [];
  //     for (const like of data) {
  //       this.dogService.getOneDog(like.thisDog.id).subscribe(
  //         data1 => {
  //           console.log(data1);
  //           this.possibleMatches.push(data1);
  //         },
  //         error => console.log(error)
  //       );
  //     }
  //     this.loadMatches(this.selectedDog.id);
  //     console.log(this.possibleMatches);
  //   });
  // }

  // getDogsByFilter() {
  //   // this.filteredDogs =  this.prefPipe.transform(this.dogs, this.selectedDog);
  //   this.filteredDogs = this.likedPipe.transform(this.dogs, this.likes);
  //   this.filteredDogs = this.dislikedPipe.transform(this.filteredDogs, this.dislikes, this.selectedDog);
  //   this.filteredDogs = this.filterOutOwner.transform(this.filteredDogs, this.user);
  //   this.loadMatches(this.selectedDog.id);
  //   this.getDogsThatLikeThisDog();
  // }

  // isLoggedin() {
  //   this.auth.checkLogin().subscribe(
  //     data => {
  //       this.user = data;
  //     }
  //   );
  // }

  setUserToNull() {
    console.log('in set user to null in home comp');

    this.user = null;
    // this.getAllDogs();
    window.location.reload();
  }
  reloadPage() {
    window.location.reload();
  }

  likeDog(thatDogId: number, content: any) {
    this.likeService.addLike(this.selectedDog.id, thatDogId).subscribe(data => {
      this.filteredDogs = null;
      this.dogService
        .getFilteredDogs(this.selectedDog.id)
        .subscribe(filtered => {
          this.filteredDogs = filtered;
          this.checkForMatch(thatDogId, content);
        });
    });
  }

  matchPopUp(dogId: number, content) {
    this.dogId = dogId;

    this.open(content);

    // if (confirm('You Matched!!')) {
    //   this.router.navigateByUrl('dogView/' + dogId);
    // }
    // document.getElementById('demo').innerHTML = txt;
  }

  checkForMatch(thatdogId: number, content) {
    this.likeService.getByThisDog(thatdogId).subscribe(likes => {
      for (const like of likes) {
        if (this.selectedDog.id === like.thatDog.id) {
          this.matchService
            .addMatch(this.selectedDog.id, thatdogId)
            .subscribe(data => {
              this.matchPopUp(thatdogId, content);
              // this.popUpDog = like.thisDog;
            });
        }
      }
    });
  }




  open(content) {
    this.modalService.open(content, {ariaLabelledBy: 'modal-basic-title'}).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }

  route() {
    this.router.navigateByUrl('dogView/' + this.dogId);
  }

  private getDismissReason(reason: any): string {
    if (reason === ModalDismissReasons.ESC) {
      return 'by pressing ESC';
    } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
      return 'by clicking on a backdrop';
    } else {
      return  `with: ${reason}`;
    }
  }


}
