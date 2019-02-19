import { FilterDogsByActivePipe } from './filter-dogs-by-active.pipe';

describe('FilterDogsByActivePipe', () => {
  it('create an instance', () => {
    const pipe = new FilterDogsByActivePipe();
    expect(pipe).toBeTruthy();
  });
});
