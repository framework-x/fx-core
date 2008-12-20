#import "XCore.h"

@interface StubbedMethodMemento : XObject {
  id _methodName;
  id _owningObject;
  IMP _previousImp;
}

// public class methods

+ (id) named: (id)methodName withPreviousImp: (IMP)imp for: (id)object;

// constructors/destructors

- (id) initWith: (id)methodName owningObject: (id)object previousImp:(IMP)imp;

- (void) dealloc;

- (id) methodName;

- (id) owningObject;

- (IMP) previousImp;

- (IMP) revert;

@end
