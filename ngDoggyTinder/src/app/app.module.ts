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
import { FilterDogsByLikedPipe } from './pipes/filter-dogs-by-liked.pipe';
import { FilterDogsByDislikePipe } from './pipes/filter-dogs-by-dislike.pipe';
import { FilterDogsByActivePipe } from './pipes/filter-dogs-by-active.pipe';
import { FilterDogsByYourPreferencesPipe } from './pipes/filter-dogs-by-your-preferences.pipe';
import { MainPageCarouselComponent } from './components/main-page-carousel/main-page-carousel.component';
import { DatePipe } from '@angular/common';
import { FilterDogMatchesPipe } from './pipes/filter-dog-matches.pipe';
import { FilterOutOwnersDogsPipe } from './pipes/filter-out-owners-dogs.pipe';

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
    FilterDogsByLikedPipe,
    FilterDogsByDislikePipe,
    FilterDogsByActivePipe,
    FilterDogsByYourPreferencesPipe,
    MainPageCarouselComponent,
    FilterDogMatchesPipe,
    FilterOutOwnersDogsPipe,
  ],

  imports: [
    AppRoutingModule,
    BrowserModule,
    FormsModule,
    HttpClientModule,
    NgbModule,
  ],

  providers: [
    AuthService,
    DisLikeService,
    DogService,
    LikeService,
    MatchService,
    MessageService,
    UserService,
    DatePipe,
    FilterDogsByLikedPipe,
    FilterDogsByDislikePipe,
    FilterDogsByActivePipe,
    FilterDogsByYourPreferencesPipe,
    FilterDogMatchesPipe,
    FilterOutOwnersDogsPipe,
    HomeComponent,
    LoginComponent,
    NavigationComponent,
    DogViewComponent

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
