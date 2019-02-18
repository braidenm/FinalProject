import { DogService } from './../../services/dog.service';
import { UserService } from './../../services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Dog } from 'src/app/models/dog';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {
  user: User;
  dogs: Dog[];
  dog: Dog;

  constructor(
    private auth: AuthService,
    private userS: UserService,
    private dogS: DogService,
    private router: Router
  ) {}

  ngOnInit() {
    this.getUser();
    if (this.user) {this.getUserDogs()};

  }

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

  logout() {
    this.auth.logout();
    if (this.auth.getCredentials() == null) {
      console.log(
        'LogoutComponent.logout(): user logged out, routing to /home.'
      );
      this.router.navigateByUrl('/home');
    } else {
      console.error('LogoutComponent.logout(): error logging out.');
    }
  }
}
