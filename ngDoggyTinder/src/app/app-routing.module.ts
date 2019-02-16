import { AboutComponent } from './components/about/about.component';
import { AdminComponent } from './components/admin/admin.component';
import { DogViewComponent } from './components/dog-view/dog-view.component';
import { HomeComponent } from './components/home/home.component';
import { NgModule } from '@angular/core';
import { NotFoundComponent } from './components/not-found/not-found.component';
import { ProfileViewComponent } from './components/profile-view/profile-view.component';
import { RegisterComponent } from './components/register/register.component';
import { Routes, RouterModule } from '@angular/router';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'home' },
  { path: 'home', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'profile', component: ProfileViewComponent },
  { path: 'dogView', component: DogViewComponent },
  { path: 'admin', component: AdminComponent },
  { path: '**', component: NotFoundComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
