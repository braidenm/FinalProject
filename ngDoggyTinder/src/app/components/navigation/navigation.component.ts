import { MessageService } from "./../../services/message.service";
import { DogService } from "./../../services/dog.service";
import { UserService } from "./../../services/user.service";
import { AuthService } from "src/app/services/auth.service";
import { Component, OnInit } from "@angular/core";
import { User } from "src/app/models/user";
import { Dog } from "src/app/models/dog";
import { Router } from "@angular/router";

@Component({
  selector: "app-navigation",
  templateUrl: "./navigation.component.html",
  styleUrls: ["./navigation.component.css"]
})
export class NavigationComponent implements OnInit {
  user: User;
  dogs: Dog[];
  dog: Dog;

  constructor(
    private auth: AuthService,
    private userS: UserService,
    private dogS: DogService,
    private router: Router,
    private messageS: MessageService
  ) {}

  ngOnInit() {
    this.getUser();

  }

  // isLoggedin() {
  //   this.auth.checkLogin().subscribe(
  //     data => {
  //       this.user = data;
  //     }
  //   );
  // }

  getUser() {
    this.userS.getLoggedInUser().subscribe(data => {
      this.user = data;
      if (this.user) {
        this.getUserDogs();
      }
    });
  }

  getUserDogs() {
    this.dogS.getAllByUser(this.user.id).subscribe(data => {
      this.dogs = data;
      if (this.dogs.length === 1) {
        this.setDog(this.dogs[0].id);
      }
    });
  }

  setDog(id: number) {
    this.dogS.setSelectedDog(id);
    this.dogS.getOneDog(id).subscribe(data => {
      this.messageS.setThisDog(data);
      this.dog = data;
    });
  }

  logout() {
    this.auth.logout();
    if (this.auth.getCredentials() == null) {
      console.log(
        "LogoutComponent.logout(): user logged out, routing to /home."
      );
      this.router.navigateByUrl("/home");
    } else {
      console.error("LogoutComponent.logout(): error logging out.");
    }
  }
}
