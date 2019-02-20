import { FilterOutOwnersDogsPipe } from './filter-out-owners-dogs.pipe';

describe('FilterOutOwnersDogsPipe', () => {
  it('create an instance', () => {
    const pipe = new FilterOutOwnersDogsPipe();
    expect(pipe).toBeTruthy();
  });
});
