import { MessageService } from './../../services/message.service';
import { Component, OnInit } from '@angular/core';
import { Dog } from 'src/app/models/dog';
import { DogService } from 'src/app/services/dog.service';
import { Message } from 'src/app/models/message';

@Component({
  selector: 'app-message',
  templateUrl: './message.component.html',
  styleUrls: ['./message.component.css']
})
export class MessageComponent implements OnInit {
  thisDog: Dog;
  thatDog: Dog;
  convo: Message[] = [];
  text = '';

  constructor(private messageS: MessageService, dogServe: DogService) { }

  ngOnInit() {
    this.thisDog = this.messageS.getThisDog();
    this.thatDog = this.messageS.getThatDog();
    this.getConversation();

  }

  getConversation() {

    this.messageS.getConversation(this.thisDog.id, this.thatDog.id).subscribe(
      data => {
        this.convo = data;
        this.convo.sort((a: Message, b: Message) => {
          return a.date.valueOf() - b.date.valueOf();
        });
      }
    );
  }

  setMessageStyle(dogId: number) {
    if (dogId === this.thisDog.id) {
      return 'sender';
    } else {
      return 'receiver';
    }
  }

  addMessage() {
    this.messageS.add(this.text, this.thisDog.id, this.thatDog.id).subscribe(
      data => {
        this.getConversation();
        this.text = '';
      }
    );
  }

}
