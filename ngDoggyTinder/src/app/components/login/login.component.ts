import { HomeComponent } from './../home/home.component';
import { NavigationComponent } from './../navigation/navigation.component';
import { Component, OnInit, Input } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';
import { invalid } from '@angular/compiler/src/render3/view/util';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  user: User = new User();
  invalid: string;
  inActive: User;

  constructor(private auth: AuthService, private userS: UserService, private router: Router,
              private nav: NavigationComponent, private h: HomeComponent) {}

  ngOnInit() {
    this.invalid = null;
  }

  login() {
    console.log(this.user);
    this.auth.login(this.user.username, this.user.password).subscribe(
      data => {
        console.log(data);
        this.getLoginUser();
      },
      err => {
        console.error('login failed');

        this.invalid = 'Invalid Login';
      }
    );
  }
  getLoginUser() {
    this.userS.getLoggedInUser().subscribe(
      userData => {
        console.log(userData);
        this.user = userData;
        if (!this.user.active) {
          this.invalid = 'non-active user';
          console.log(this.invalid);
          this.inActive = this.user;
          console.log('in if for checking active');
          this.auth.logout();
          this.user = new User();
        } else {

          this.nav.reload();
          console.error('login succeeded');
          this.invalid = null;
          this.h.user = this.user;
          this.h.reloadPage();
          this.router.navigateByUrl('home');
        }

      },
      userErr => {
        this.invalid = 'non-active user, contact system admin';
        console.error('Error retrieving logged in user');

      }
    );
  }
  reactivate() {
    this.inActive.active = true;
    this.userS.update(this.inActive).subscribe(data => {
      this.invalid = null;
      this.user = data;
    },
    err => {
      console.log('error in reactivate login comp');

    }
    );
  }
}
