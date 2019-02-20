import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { Dog } from 'src/app/models/dog';
import { UserService } from 'src/app/services/user.service';
import { DogService } from 'src/app/services/dog.service';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent implements OnInit {

  user = new User();
  selectedDog = new Dog();

  constructor(private userService: UserService, private dogService: DogService) { }

  ngOnInit() {
    this.reload();
  }

  reload() {
    this.userService.getLoggedInUser().subscribe(
      userData => {
        this.user = userData;
        this.getSelectedDog();


      },
      error => console.log(error)
    );
  }

  getSelectedDog() {
    this.selectedDog = this.dogService.getSelectedDog();
  }

}
