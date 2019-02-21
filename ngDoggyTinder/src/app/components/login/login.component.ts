import { NavigationComponent } from './../navigation/navigation.component';
import { Component, OnInit, Input } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  user: User = new User();
  invalid: string;

  constructor(private auth: AuthService, private userS: UserService, private router: Router,
              private nav: NavigationComponent){}

  ngOnInit() {
    this.invalid = null;
  }

  login() {
    console.log(this.user);
    this.auth.login(this.user.username, this.user.password).subscribe(
      data => {
        console.log(data);

        this.userS.getLoggedInUser().subscribe(
          userData => {
            console.log(userData);
            this.user = userData;
            this.nav.reload();

            console.error('login succeeded');
            this.invalid = null;
            this.router.navigateByUrl('home');
          },
          userErr => {
            console.error('Error retrieving logged in user');

          }
        );
      },
      err => {
        console.error('login failed');

        this.invalid = 'Invalid Login';
      }
    );
  }
}
