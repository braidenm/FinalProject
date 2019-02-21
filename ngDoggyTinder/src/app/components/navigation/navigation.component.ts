import { MessageService } from './../../services/message.service';
import { DogService } from './../../services/dog.service';
import { UserService } from './../../services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Dog } from 'src/app/models/dog';
import { Router } from '@angular/router';
import { HomeComponent } from '../home/home.component';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

  user: User;
  dogs: Dog[];
  dog: Dog;
  selectedDog = new Dog();

  constructor(
    private auth: AuthService,
    private userS: UserService,
    private dogS: DogService,
    private router: Router,
    private messageS: MessageService,
    private h: HomeComponent,
  ) {}

  ngOnInit() {
    this.reload();

  }

  // isLoggedin() {
  //   if( )
  //   this.auth.checkLogin().subscribe(
  //     data => {
  //       this.user = data;
  //     }
  //   );
  // }
  reload() {
    this.getUser();
    this.getSelectedDog();
  }

  getSelectedDog() {
    this.selectedDog = this.dogS.getSelectedDog();
  }

  getUser() {
    this.userS.getLoggedInUser().subscribe(data => {
      this.user = data;
      console.log(this.user);

      if (this.user) {
        this.getUserDogs();
      }
    });
  }

  getUserDogs() {
    this.dogS.getAllByUser(this.user.id).subscribe(data => {
      console.log(data);
      this.dogs = data;
      if (!this.dogS.getSelectedDog()) {
        this.setDog(this.dogs[0]);
      }
    });
  }

  setDog(dog: Dog) {
    console.log(dog);
    this.dogS.setSelectedDog(dog);
    this.messageS.setThisDog(dog);
    this.router.navigateByUrl('home');

  }

  logout() {
    this.auth.logout();
    if (!this.auth.checkLogin()) {
      this.user = null;
      console.log(
        'LogoutComponent.logout(): user logged out, routing to /home.'
      );
      this.h.user = null;
      this.h.setUserToNull();
      // this.h.getAllDogs();
      this.router.navigateByUrl('home');
    } else {
      console.error('LogoutComponent.logout(): error logging out.');
    }
  }
}
