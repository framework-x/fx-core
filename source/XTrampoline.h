// ****************************************
// Generated from .m file
// ****************************************

#import "XObject.h"

@interface XTrampoline : XObject {
  id _bounceBackMethod;
  id _targetObject;
}
+ (id) newWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod;
- (id) initWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod;
- (void) dealloc;
- (id) bounceBackMethod;
- (void) forwardInvocation: (NSInvocation*)invocation;
- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector;
- (id) targetObject;
@end
