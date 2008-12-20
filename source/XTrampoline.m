#import "XTrampoline.h"

#import "XObject.h"

/*
#import "XObject.h"

@interface XTrampoline : XObject {
  id _bounceBackMethod;
  id _targetObject;
}
@end
*/

// todo: z: should extend XProxy (not XObject) 
@implementation XTrampoline

+ (id) newWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod {
  return [[self alloc] initWith:targetObject bounceBackMethodName:bounceBackMethod];
}

// constructors /destructors

- (id) initWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod {
  if (self = [super init]) {
    _targetObject = [targetObject retain];
    _bounceBackMethod = [bounceBackMethod retain];
  }
  return self;
}

- (void) dealloc { 
  [_bounceBackMethod release];
  [_targetObject release];
  [super dealloc]; 
}

// public instance methods

- (id) bounceBackMethod {
  return _bounceBackMethod;
}

- (void) forwardInvocation: (NSInvocation*)invocation {
  [_targetObject performSelector:NSSelectorFromString(_bounceBackMethod) withObject:invocation];
}

- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector {
  id sig = [_targetObject higherOrderMethodSignatureForSelector:selector];
  return sig;
}


- (id) targetObject {
  return _targetObject;
}

@end
