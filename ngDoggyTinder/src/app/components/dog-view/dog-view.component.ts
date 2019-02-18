import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-dog-view',
  templateUrl: './dog-view.component.html',
  styleUrls: ['./dog-view.component.css']
})
export class DogViewComponent implements OnInit {

  private user: User;

  constructor(private userve: UserService) { }

  ngOnInit() {
    this.userve.getLoggedInUser().subscribe(
      data => this.user = data
    );

    console.log(this.user);

  }

}
