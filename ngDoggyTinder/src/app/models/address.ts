export class Address {
  id: number;
  street: string;
  city: string;
  state: string;
  zip: number;

  constructor(
    id?: number,
    street?: string,
    city?: string,
    state?: string,
    zip?: number
  ) {
    this.id = id;
    this.street = street;
    this.city = city;
    this.state = state;
    this.zip = zip;
  }
}
