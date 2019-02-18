import { FilterDogsByDislikePipe } from './filter-dogs-by-dislike.pipe';

describe('FilterDogsByDislikePipe', () => {
  it('create an instance', () => {
    const pipe = new FilterDogsByDislikePipe();
    expect(pipe).toBeTruthy();
  });
});
