import { TestBed } from '@angular/core/testing';

import { DisLikeService } from './dis-like.service';

describe('DisLikeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: DisLikeService = TestBed.get(DisLikeService);
    expect(service).toBeTruthy();
  });
});
