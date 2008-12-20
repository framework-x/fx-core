
#import "XAsyncTestHelper.h"

#import "TestHelper.h"

@implementation XAsyncTestHelper

// public instance methods

- (id) setResponseReceived: (BOOL)value {
  _responseReceived = value;
  return self;
}

- (id) waitForCallback {
  int count = 0;
  while (count++ <= 20 && !_responseReceived) {
    id timeToStop = [NSDate dateWithTimeIntervalSinceNow:0.25];
    [[NSRunLoop currentRunLoop] runUntilDate:timeToStop];    
  }
  if (!_responseReceived) {
    @throw [NSException exceptionWithName:@"Mr Jones" reason:@"Timed out waiting for response" userInfo:nil]; 
  }
  _responseReceived = NO;    
  return self;
}

// protected instance methods

@end
