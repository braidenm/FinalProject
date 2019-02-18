import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
user: User = new User();
invalid: string;

  constructor(private auth: AuthService, private router: Router) { }

  ngOnInit() {
    this.invalid = null;
  }

  login() {
    console.log(this.user);
    this.auth.login(this.user.username, this.user.password).subscribe(
      data => {
        this.invalid = null;
        this.router.navigateByUrl('home');
      },
      err => this.invalid = 'Invalid Login'

    );

  }
}
