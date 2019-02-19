import { FilterDogsByYourPreferencesPipe } from './filter-dogs-by-your-preferences.pipe';

describe('FilterDogsByYourPreferencesPipe', () => {
  it('create an instance', () => {
    const pipe = new FilterDogsByYourPreferencesPipe();
    expect(pipe).toBeTruthy();
  });
});
