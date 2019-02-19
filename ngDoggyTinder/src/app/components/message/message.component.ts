import { MatchService } from './../../services/match.service';
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


  constructor(private messageS: MessageService, private dogServe: DogService) { }

  ngOnInit() {
    this.thisDog = this.messageS.getThisDog();
    this.thatDog = this.messageS.getThatDog();
    console.log(this.thisDog);
    console.log(this.thatDog);
    this.getConversation();

  }


  getConversation() {

    this.messageS.getConversation(this.thisDog.id, this.thatDog.id).subscribe(
      data => {
        for (const mess of data) {
          if (mess.read === false) {
            mess.read = true;
            this.messageS.update(mess).subscribe();
          }
          this.convo = data;
          console.log(this.convo[0].date.valueOf());
          console.log(typeof this.convo[0].date);


        }
      }
      );
      console.log(this.convo);

    this.convo = this.convo.sort((a: Message, b: Message) => {
      console.log(a);
      // return new Date(a.date.valueOf).valueOf() - new Date(b.date).valueOf();
      if (a.date > b.date) {
        return -1;
      }
      return 1;
    });
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
