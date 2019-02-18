import { AboutComponent } from './components/about/about.component';
import { AdminComponent } from './components/admin/admin.component';
import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { AuthService } from './services/auth.service';
import { BrowserModule } from '@angular/platform-browser';
import { DisLikeService } from './services/dis-like.service';
import { DogService } from './services/dog.service';
import { DogViewComponent } from './components/dog-view/dog-view.component';
import { FormsModule } from '@angular/forms';
import { HomeComponent } from './components/home/home.component';
import { HttpClientModule } from '@angular/common/http';
import { LikeService } from './services/like.service';
import { LoginComponent } from './components/login/login.component';
import { MatchesComponent } from './components/matches/matches.component';
import { MatchService } from './services/match.service';
import { MessageComponent } from './components/message/message.component';
import { MessageService } from './services/message.service';
import { NavigationComponent } from './components/navigation/navigation.component';
import { NgModule } from '@angular/core';
import { NgbModule} from '@ng-bootstrap/ng-bootstrap';
import { ProfileViewComponent } from './components/profile-view/profile-view.component';
import { RegisterComponent } from './components/register/register.component';
import { UserService } from './services/user.service';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { DogRegisterComponent } from './components/dog-register/dog-register.component';

@NgModule({
  declarations: [
    AboutComponent,
    AdminComponent,
    AppComponent,
    DogViewComponent,
    HomeComponent,
    LoginComponent,
    MatchesComponent,
    MessageComponent,
    NavigationComponent,
    ProfileViewComponent,
    RegisterComponent,
    NotFoundComponent,
    DogRegisterComponent,

  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    FormsModule,
    HttpClientModule,
    NgbModule.forRoot(),
  ],
  providers: [
    AuthService,
    DisLikeService,
    DogService,
    LikeService,
    MatchService,
    MessageService,
    UserService,

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
