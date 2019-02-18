import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  user = new User();

  constructor(private authService: AuthService) { }

  ngOnInit() {
  }

  addUser() {
    this.authService.register(this.user).subscribe(
      data => {},
      error => console.log(error)
    );
  }


}
