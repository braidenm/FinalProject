import { UserService } from './../../services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

private user: User;

  constructor(private auth: AuthService, private userS: UserService) { }

  ngOnInit() {

  }

  isLoggedin() {
    return this.auth.checkLogin;
  }



}
