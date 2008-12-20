#import "StubbedMethodMemento.h"

@implementation StubbedMethodMemento


// public class methods

+ (id) named: (id)methodName withPreviousImp: (IMP)imp for: (id)object {
  return [[[self alloc] initWith:methodName owningObject:object previousImp:imp] autorelease];
}

// constructors/destructors

- (id) initWith: (id)methodName owningObject: (id)object previousImp:(IMP)imp {
  if (self = [super init]) {
    _methodName = [methodName retain];
    _owningObject = [object retain];
    _previousImp = imp;
  }
  return self;
}

- (void) dealloc {
  [_methodName release];
  [_owningObject release];
	[super dealloc];
}

// public instance methods

- (BOOL) isEqual: (id)other {
  if (isNilOrNull(other)) {
    return false;
  }
  return equalOrBothNil(_methodName, [other methodName]) && equalOrBothNil(_owningObject, [other owningObject]) && _previousImp == [other previousImp];
}

- (id) methodName {
  return _methodName;
}

- (id) owningObject {
  return _owningObject;
}

- (IMP) previousImp {
  return _previousImp;
}

- (IMP) revert {  
  return method_setImplementation([[_owningObject getMethod:_methodName] method], _previousImp);    
}


@end
