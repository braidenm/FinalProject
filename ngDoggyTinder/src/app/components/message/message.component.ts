import { MatchService } from './../../services/match.service';
import { MatchService } from 'src/app/services/match.service';
import { MessageService } from './../../services/message.service';
import { Component, OnInit } from '@angular/core';
import { Dog } from 'src/app/models/dog';
import { DogService } from 'src/app/services/dog.service';
import { Message } from 'src/app/models/message';
import { ifStmt } from '@angular/compiler/src/output/output_ast';

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
  isMatch = false;

  constructor(private messageS: MessageService, private dogServe: DogService, private matchServe: MatchService) { }

  ngOnInit() {
    this.thisDog = this.messageS.getThisDog();
    this.thatDog = this.messageS.getThatDog();
    console.log(this.thisDog);
    console.log(this.thatDog);
    this.getConversation();

  }

  checkIfMatch() {
    this.matchServe.index(this.thisDog.id).subscribe(
      data => {
        for (const match of data) {
          if (this.thatDog.id === match.thatDog.id) {
            this.isMatch = true;
            break;
          }
        }
      }
    );
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
