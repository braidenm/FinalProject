import { FilterDogsByLikedPipe } from './filter-dogs-by-liked.pipe';

describe('FilterDogsByLikedPipe', () => {
  it('create an instance', () => {
    const pipe = new FilterDogsByLikedPipe();
    expect(pipe).toBeTruthy();
  });
});
