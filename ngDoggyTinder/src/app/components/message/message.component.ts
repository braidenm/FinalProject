import { MessageService } from './../../services/message.service';
import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Dog } from 'src/app/models/dog';
import { DogService } from 'src/app/services/dog.service';
import { Message } from '@angular/compiler/src/i18n/i18n_ast';

@Component({
  selector: 'app-message',
  templateUrl: './message.component.html',
  styleUrls: ['./message.component.css']
})
export class MessageComponent implements OnInit {
  thisDog: Dog;
  thatDog: Dog;
  convo: Message[];

  constructor(private messageS: MessageService, dogServe: DogService) { }

  ngOnInit() {
    this.thisDog = this.messageS.getThisDog();
    this.thatDog = this.messageS.getThatDog();

  }

  getConversation(this) {

  }

}
