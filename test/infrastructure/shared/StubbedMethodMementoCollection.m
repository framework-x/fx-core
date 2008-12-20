#import "StubbedMethodMementoCollection.h"

id _mementos;

@implementation StubbedMethodMementoCollection

// public class methods 

+ (id) add: (id)memento {
  [_mementos add:memento];
  return self;
}

+ (void) initialize {
  if (!_mementos) {
    _mementos = [[XArray empty] retain];
  }
}

+ (id) revertAll {
  for (id memento in _mementos) {
    [memento revert];
  }
  [_mementos clear];  
  return self;
}

+ (id) _mementos {
  return _mementos;
}

// public instance methods


@end


