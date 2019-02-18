import { DogService } from './../../services/dog.service';
import { UserService } from './../../services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Dog } from 'src/app/models/dog';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  user: User;
  dogs: Dog[];

  constructor(
    private auth: AuthService,
    private userS: UserService,
    private dogS: DogService
  ) {}

  ngOnInit() {}

  // isLoggedin() {
  //   this.auth.checkLogin().subscribe(
  //     data => {
  //       this.user = data;
  //     }
  //   );
  // }

  getUser() {
    this.userS.getLoggedInUser().subscribe(data => {
      this.user = data;
    });
  }

  getUserDogs() {
    this.dogS.getAllByUser(this.user.id).subscribe(data => {
      this.dogs = data;
    });
  }

  setDog(id: number) {
    this.dogS.setSelectedDog(id);
  }
}
