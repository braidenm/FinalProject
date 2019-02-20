import { Component, OnInit, Input } from '@angular/core';
import { Dog } from 'src/app/models/dog';
import { NONE_TYPE } from '@angular/compiler/src/output/output_ast';

@Component({
  selector: 'app-main-page-carousel',
  templateUrl: './main-page-carousel.component.html',
  styleUrls: ['./main-page-carousel.component.css']
})
export class MainPageCarouselComponent implements OnInit {
  images: string[] = [
    'assets/photos/dogsChasing.jpg',
    'assets/photos/dogsInField.jpg',
    'assets/photos/dogsInHammock.jpg',
    'assets/photos/dogsInTheSnow.jpg'
  ];
  @Input() dog: Dog;
  @Input() dogs: Dog[];
  @Input() possibleMatches: Dog[];

  showNavigationIndicators = false;
  interval = 1000000;

  constructor() {}

  ngOnInit() {}
}
