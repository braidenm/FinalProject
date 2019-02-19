import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { DogService } from 'src/app/services/dog.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  constructor(private userService: UserService, private dogService: DogService) { }

  ngOnInit() {
  }

}
