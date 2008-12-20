#import "XTestCase.h"

@interface XAsynchronousTestCase : XTestCase {
  id _numArgs;
  id _params;
  BOOL _responseReceived;
}


- (id) defineCallbackForWait: (id)callbackMethodName;
- (id) waitForCallback;

- (id) _callbackMethod: (id)firstItem, ...;

@end
