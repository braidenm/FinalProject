import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { NgForm } from '@angular/forms';
import { Address } from 'src/app/models/address';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  user = new User();
  address = new Address();

  constructor(private authService: AuthService) { }

  ngOnInit() {
  }

  addUser() {
    this.user.address = this.address;
    this.authService.register(this.user).subscribe(
      data => {},
      error => console.log(error)
    );
  }


}
